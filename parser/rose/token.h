/* This file was generated by SableCC (http://www.sablecc.org/). */

#ifndef __rose__token_hh__
#define __rose__token_hh__

namespace rose {

class Token : public Node {
protected:
  inline Token(_GenericNode *obj) : Node(obj) { }
  friend class Lexer;

public:
  inline Token() : Node() { }

  inline const std::string& getText () const { return ptr()->text; }
  inline int getLine () const { return ptr()->line; }
  inline int getPos () const { return ptr()->pos; }

  inline void setText (const std::string& text)
  {
    if ( ptr()->type_info->token_is_mutable )
        ptr()->text = text;
    else
        throw Exception("Trying to set immutable token text");
  }

  inline void setLine (int line) { ptr()->line = line; }
  inline void setPos (int pos) { ptr()->pos = pos; }

  inline int getIndex () const { return ptr()->type_info->token_index; }

  static const _TypeInfo type_info;

  inline Token clone () const { return Node::clone().unsafe_cast<Token>(); }

  inline void replaceBy (Token node) { Node::replaceBy (node); }

protected:
  static Token make (const _TypeInfo *type_info, int line, int pos, const std::string& text)
  { return _GenericNode::initToken (type_info, line, pos, text); }

  inline void unsafeSetText(const std::string& text)
  { ptr()->text = text; }

private:
  void replaceBy (Node node); // hide it
};

class TEOF : public Token {
public:
  static inline TEOF make () { return make(0, 0); }

  static inline TEOF make (int line, int pos)
  { return Token::make(&type_info, line, pos, "").unsafe_cast<TEOF>(); }

  static const _TypeInfo type_info;

  inline TEOF clone () const { return Node::clone().unsafe_cast<TEOF>(); }

private:
  void setText (const std::string& text); // { } // Get error at compile time
};

class TNumber : public Token {
public:
  static inline TNumber make (const std::string& text) { return make(text, 0, 0); }
  static inline TNumber make (const std::string& text, int line, int pos)
  { return Token::make(&type_info, line, pos, text).unsafe_cast<TNumber>(); }

  inline void setText (const std::string& text) // Safe to set in variable token, no safety needed
  { unsafeSetText (text); }

  static const _TypeInfo type_info;

  inline TNumber clone () const { return Node::clone().unsafe_cast<TNumber>(); }

  inline void replaceBy (TNumber node) { Node::replaceBy (node); }

private:
  void replaceBy (Token node);
};

class TIdentifier : public Token {
public:
  static inline TIdentifier make (const std::string& text) { return make(text, 0, 0); }
  static inline TIdentifier make (const std::string& text, int line, int pos)
  { return Token::make(&type_info, line, pos, text).unsafe_cast<TIdentifier>(); }

  inline void setText (const std::string& text) // Safe to set in variable token, no safety needed
  { unsafeSetText (text); }

  static const _TypeInfo type_info;

  inline TIdentifier clone () const { return Node::clone().unsafe_cast<TIdentifier>(); }

  inline void replaceBy (TIdentifier node) { Node::replaceBy (node); }

private:
  void replaceBy (Token node);
};

class TColor : public Token {
public:
  static inline TColor make (const std::string& text) { return make(text, 0, 0); }
  static inline TColor make (const std::string& text, int line, int pos)
  { return Token::make(&type_info, line, pos, text).unsafe_cast<TColor>(); }

  inline void setText (const std::string& text) // Safe to set in variable token, no safety needed
  { unsafeSetText (text); }

  static const _TypeInfo type_info;

  inline TColor clone () const { return Node::clone().unsafe_cast<TColor>(); }

  inline void replaceBy (TColor node) { Node::replaceBy (node); }

private:
  void replaceBy (Token node);
};

class TBlank : public Token {
public:
  static inline TBlank make (const std::string& text) { return make(text, 0, 0); }
  static inline TBlank make (const std::string& text, int line, int pos)
  { return Token::make(&type_info, line, pos, text).unsafe_cast<TBlank>(); }

  inline void setText (const std::string& text) // Safe to set in variable token, no safety needed
  { unsafeSetText (text); }

  static const _TypeInfo type_info;

  inline TBlank clone () const { return Node::clone().unsafe_cast<TBlank>(); }

  inline void replaceBy (TBlank node) { Node::replaceBy (node); }

private:
  void replaceBy (Token node);
};

class TComment : public Token {
public:
  static inline TComment make (const std::string& text) { return make(text, 0, 0); }
  static inline TComment make (const std::string& text, int line, int pos)
  { return Token::make(&type_info, line, pos, text).unsafe_cast<TComment>(); }

  inline void setText (const std::string& text) // Safe to set in variable token, no safety needed
  { unsafeSetText (text); }

  static const _TypeInfo type_info;

  inline TComment clone () const { return Node::clone().unsafe_cast<TComment>(); }

  inline void replaceBy (TComment node) { Node::replaceBy (node); }

private:
  void replaceBy (Token node);
};


class TDefy : public Token {
public:
  static inline TDefy make () { return make(0, 0); }
  static inline TDefy make (int line, int pos)
  { return Token::make(&type_info, line, pos, "defy").unsafe_cast<TDefy>(); }

  static const _TypeInfo type_info;

  inline TDefy clone () const { return Node::clone().unsafe_cast<TDefy>(); }

  inline void replaceBy (TDefy node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TDone : public Token {
public:
  static inline TDone make () { return make(0, 0); }
  static inline TDone make (int line, int pos)
  { return Token::make(&type_info, line, pos, "done").unsafe_cast<TDone>(); }

  static const _TypeInfo type_info;

  inline TDone clone () const { return Node::clone().unsafe_cast<TDone>(); }

  inline void replaceBy (TDone node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TDraw : public Token {
public:
  static inline TDraw make () { return make(0, 0); }
  static inline TDraw make (int line, int pos)
  { return Token::make(&type_info, line, pos, "draw").unsafe_cast<TDraw>(); }

  static const _TypeInfo type_info;

  inline TDraw clone () const { return Node::clone().unsafe_cast<TDraw>(); }

  inline void replaceBy (TDraw node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TElse : public Token {
public:
  static inline TElse make () { return make(0, 0); }
  static inline TElse make (int line, int pos)
  { return Token::make(&type_info, line, pos, "else").unsafe_cast<TElse>(); }

  static const _TypeInfo type_info;

  inline TElse clone () const { return Node::clone().unsafe_cast<TElse>(); }

  inline void replaceBy (TElse node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TFace : public Token {
public:
  static inline TFace make () { return make(0, 0); }
  static inline TFace make (int line, int pos)
  { return Token::make(&type_info, line, pos, "face").unsafe_cast<TFace>(); }

  static const _TypeInfo type_info;

  inline TFace clone () const { return Node::clone().unsafe_cast<TFace>(); }

  inline void replaceBy (TFace node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TFork : public Token {
public:
  static inline TFork make () { return make(0, 0); }
  static inline TFork make (int line, int pos)
  { return Token::make(&type_info, line, pos, "fork").unsafe_cast<TFork>(); }

  static const _TypeInfo type_info;

  inline TFork clone () const { return Node::clone().unsafe_cast<TFork>(); }

  inline void replaceBy (TFork node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TJump : public Token {
public:
  static inline TJump make () { return make(0, 0); }
  static inline TJump make (int line, int pos)
  { return Token::make(&type_info, line, pos, "jump").unsafe_cast<TJump>(); }

  static const _TypeInfo type_info;

  inline TJump clone () const { return Node::clone().unsafe_cast<TJump>(); }

  inline void replaceBy (TJump node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TMove : public Token {
public:
  static inline TMove make () { return make(0, 0); }
  static inline TMove make (int line, int pos)
  { return Token::make(&type_info, line, pos, "move").unsafe_cast<TMove>(); }

  static const _TypeInfo type_info;

  inline TMove clone () const { return Node::clone().unsafe_cast<TMove>(); }

  inline void replaceBy (TMove node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TPlan : public Token {
public:
  static inline TPlan make () { return make(0, 0); }
  static inline TPlan make (int line, int pos)
  { return Token::make(&type_info, line, pos, "plan").unsafe_cast<TPlan>(); }

  static const _TypeInfo type_info;

  inline TPlan clone () const { return Node::clone().unsafe_cast<TPlan>(); }

  inline void replaceBy (TPlan node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TPlot : public Token {
public:
  static inline TPlot make () { return make(0, 0); }
  static inline TPlot make (int line, int pos)
  { return Token::make(&type_info, line, pos, "plot").unsafe_cast<TPlot>(); }

  static const _TypeInfo type_info;

  inline TPlot clone () const { return Node::clone().unsafe_cast<TPlot>(); }

  inline void replaceBy (TPlot node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TProc : public Token {
public:
  static inline TProc make () { return make(0, 0); }
  static inline TProc make (int line, int pos)
  { return Token::make(&type_info, line, pos, "proc").unsafe_cast<TProc>(); }

  static const _TypeInfo type_info;

  inline TProc clone () const { return Node::clone().unsafe_cast<TProc>(); }

  inline void replaceBy (TProc node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TRand : public Token {
public:
  static inline TRand make () { return make(0, 0); }
  static inline TRand make (int line, int pos)
  { return Token::make(&type_info, line, pos, "rand").unsafe_cast<TRand>(); }

  static const _TypeInfo type_info;

  inline TRand clone () const { return Node::clone().unsafe_cast<TRand>(); }

  inline void replaceBy (TRand node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TSeed : public Token {
public:
  static inline TSeed make () { return make(0, 0); }
  static inline TSeed make (int line, int pos)
  { return Token::make(&type_info, line, pos, "seed").unsafe_cast<TSeed>(); }

  static const _TypeInfo type_info;

  inline TSeed clone () const { return Node::clone().unsafe_cast<TSeed>(); }

  inline void replaceBy (TSeed node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TSine : public Token {
public:
  static inline TSine make () { return make(0, 0); }
  static inline TSine make (int line, int pos)
  { return Token::make(&type_info, line, pos, "sine").unsafe_cast<TSine>(); }

  static const _TypeInfo type_info;

  inline TSine clone () const { return Node::clone().unsafe_cast<TSine>(); }

  inline void replaceBy (TSine node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TSize : public Token {
public:
  static inline TSize make () { return make(0, 0); }
  static inline TSize make (int line, int pos)
  { return Token::make(&type_info, line, pos, "size").unsafe_cast<TSize>(); }

  static const _TypeInfo type_info;

  inline TSize clone () const { return Node::clone().unsafe_cast<TSize>(); }

  inline void replaceBy (TSize node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TTemp : public Token {
public:
  static inline TTemp make () { return make(0, 0); }
  static inline TTemp make (int line, int pos)
  { return Token::make(&type_info, line, pos, "temp").unsafe_cast<TTemp>(); }

  static const _TypeInfo type_info;

  inline TTemp clone () const { return Node::clone().unsafe_cast<TTemp>(); }

  inline void replaceBy (TTemp node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TTint : public Token {
public:
  static inline TTint make () { return make(0, 0); }
  static inline TTint make (int line, int pos)
  { return Token::make(&type_info, line, pos, "tint").unsafe_cast<TTint>(); }

  static const _TypeInfo type_info;

  inline TTint clone () const { return Node::clone().unsafe_cast<TTint>(); }

  inline void replaceBy (TTint node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TTurn : public Token {
public:
  static inline TTurn make () { return make(0, 0); }
  static inline TTurn make (int line, int pos)
  { return Token::make(&type_info, line, pos, "turn").unsafe_cast<TTurn>(); }

  static const _TypeInfo type_info;

  inline TTurn clone () const { return Node::clone().unsafe_cast<TTurn>(); }

  inline void replaceBy (TTurn node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TWait : public Token {
public:
  static inline TWait make () { return make(0, 0); }
  static inline TWait make (int line, int pos)
  { return Token::make(&type_info, line, pos, "wait").unsafe_cast<TWait>(); }

  static const _TypeInfo type_info;

  inline TWait clone () const { return Node::clone().unsafe_cast<TWait>(); }

  inline void replaceBy (TWait node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TWhen : public Token {
public:
  static inline TWhen make () { return make(0, 0); }
  static inline TWhen make (int line, int pos)
  { return Token::make(&type_info, line, pos, "when").unsafe_cast<TWhen>(); }

  static const _TypeInfo type_info;

  inline TWhen clone () const { return Node::clone().unsafe_cast<TWhen>(); }

  inline void replaceBy (TWhen node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TLPar : public Token {
public:
  static inline TLPar make () { return make(0, 0); }
  static inline TLPar make (int line, int pos)
  { return Token::make(&type_info, line, pos, "(").unsafe_cast<TLPar>(); }

  static const _TypeInfo type_info;

  inline TLPar clone () const { return Node::clone().unsafe_cast<TLPar>(); }

  inline void replaceBy (TLPar node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TRPar : public Token {
public:
  static inline TRPar make () { return make(0, 0); }
  static inline TRPar make (int line, int pos)
  { return Token::make(&type_info, line, pos, ")").unsafe_cast<TRPar>(); }

  static const _TypeInfo type_info;

  inline TRPar clone () const { return Node::clone().unsafe_cast<TRPar>(); }

  inline void replaceBy (TRPar node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TPlus : public Token {
public:
  static inline TPlus make () { return make(0, 0); }
  static inline TPlus make (int line, int pos)
  { return Token::make(&type_info, line, pos, "+").unsafe_cast<TPlus>(); }

  static const _TypeInfo type_info;

  inline TPlus clone () const { return Node::clone().unsafe_cast<TPlus>(); }

  inline void replaceBy (TPlus node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TMinus : public Token {
public:
  static inline TMinus make () { return make(0, 0); }
  static inline TMinus make (int line, int pos)
  { return Token::make(&type_info, line, pos, "-").unsafe_cast<TMinus>(); }

  static const _TypeInfo type_info;

  inline TMinus clone () const { return Node::clone().unsafe_cast<TMinus>(); }

  inline void replaceBy (TMinus node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TMul : public Token {
public:
  static inline TMul make () { return make(0, 0); }
  static inline TMul make (int line, int pos)
  { return Token::make(&type_info, line, pos, "*").unsafe_cast<TMul>(); }

  static const _TypeInfo type_info;

  inline TMul clone () const { return Node::clone().unsafe_cast<TMul>(); }

  inline void replaceBy (TMul node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TDiv : public Token {
public:
  static inline TDiv make () { return make(0, 0); }
  static inline TDiv make (int line, int pos)
  { return Token::make(&type_info, line, pos, "/").unsafe_cast<TDiv>(); }

  static const _TypeInfo type_info;

  inline TDiv clone () const { return Node::clone().unsafe_cast<TDiv>(); }

  inline void replaceBy (TDiv node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TEq : public Token {
public:
  static inline TEq make () { return make(0, 0); }
  static inline TEq make (int line, int pos)
  { return Token::make(&type_info, line, pos, "==").unsafe_cast<TEq>(); }

  static const _TypeInfo type_info;

  inline TEq clone () const { return Node::clone().unsafe_cast<TEq>(); }

  inline void replaceBy (TEq node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TNe : public Token {
public:
  static inline TNe make () { return make(0, 0); }
  static inline TNe make (int line, int pos)
  { return Token::make(&type_info, line, pos, "!=").unsafe_cast<TNe>(); }

  static const _TypeInfo type_info;

  inline TNe clone () const { return Node::clone().unsafe_cast<TNe>(); }

  inline void replaceBy (TNe node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TLt : public Token {
public:
  static inline TLt make () { return make(0, 0); }
  static inline TLt make (int line, int pos)
  { return Token::make(&type_info, line, pos, "<").unsafe_cast<TLt>(); }

  static const _TypeInfo type_info;

  inline TLt clone () const { return Node::clone().unsafe_cast<TLt>(); }

  inline void replaceBy (TLt node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TLe : public Token {
public:
  static inline TLe make () { return make(0, 0); }
  static inline TLe make (int line, int pos)
  { return Token::make(&type_info, line, pos, "<=").unsafe_cast<TLe>(); }

  static const _TypeInfo type_info;

  inline TLe clone () const { return Node::clone().unsafe_cast<TLe>(); }

  inline void replaceBy (TLe node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TGt : public Token {
public:
  static inline TGt make () { return make(0, 0); }
  static inline TGt make (int line, int pos)
  { return Token::make(&type_info, line, pos, ">").unsafe_cast<TGt>(); }

  static const _TypeInfo type_info;

  inline TGt clone () const { return Node::clone().unsafe_cast<TGt>(); }

  inline void replaceBy (TGt node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TGe : public Token {
public:
  static inline TGe make () { return make(0, 0); }
  static inline TGe make (int line, int pos)
  { return Token::make(&type_info, line, pos, ">=").unsafe_cast<TGe>(); }

  static const _TypeInfo type_info;

  inline TGe clone () const { return Node::clone().unsafe_cast<TGe>(); }

  inline void replaceBy (TGe node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TAnd : public Token {
public:
  static inline TAnd make () { return make(0, 0); }
  static inline TAnd make (int line, int pos)
  { return Token::make(&type_info, line, pos, "&").unsafe_cast<TAnd>(); }

  static const _TypeInfo type_info;

  inline TAnd clone () const { return Node::clone().unsafe_cast<TAnd>(); }

  inline void replaceBy (TAnd node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TOr : public Token {
public:
  static inline TOr make () { return make(0, 0); }
  static inline TOr make (int line, int pos)
  { return Token::make(&type_info, line, pos, "|").unsafe_cast<TOr>(); }

  static const _TypeInfo type_info;

  inline TOr clone () const { return Node::clone().unsafe_cast<TOr>(); }

  inline void replaceBy (TOr node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TAssign : public Token {
public:
  static inline TAssign make () { return make(0, 0); }
  static inline TAssign make (int line, int pos)
  { return Token::make(&type_info, line, pos, "=").unsafe_cast<TAssign>(); }

  static const _TypeInfo type_info;

  inline TAssign clone () const { return Node::clone().unsafe_cast<TAssign>(); }

  inline void replaceBy (TAssign node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TNeg : public Token {
public:
  static inline TNeg make () { return make(0, 0); }
  static inline TNeg make (int line, int pos)
  { return Token::make(&type_info, line, pos, "~").unsafe_cast<TNeg>(); }

  static const _TypeInfo type_info;

  inline TNeg clone () const { return Node::clone().unsafe_cast<TNeg>(); }

  inline void replaceBy (TNeg node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TQuestion : public Token {
public:
  static inline TQuestion make () { return make(0, 0); }
  static inline TQuestion make (int line, int pos)
  { return Token::make(&type_info, line, pos, "?").unsafe_cast<TQuestion>(); }

  static const _TypeInfo type_info;

  inline TQuestion clone () const { return Node::clone().unsafe_cast<TQuestion>(); }

  inline void replaceBy (TQuestion node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};

class TColon : public Token {
public:
  static inline TColon make () { return make(0, 0); }
  static inline TColon make (int line, int pos)
  { return Token::make(&type_info, line, pos, ":").unsafe_cast<TColon>(); }

  static const _TypeInfo type_info;

  inline TColon clone () const { return Node::clone().unsafe_cast<TColon>(); }

  inline void replaceBy (TColon node) { Node::replaceBy (node); }

private:
  void setText (const std::string& text); // Get error at compile time
  void replaceBy (Token node);
};


} // namespace rose {

#endif // !__rose__token_hh__
