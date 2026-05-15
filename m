Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F273FF1DA
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860534; cv=none; b=g1wLSF11NwDCBtq48PpBpg0gzMpl5B8+0hJJsF/a3D+O1bMiPMSanV9qzo4nIM9pZr66KWrIGsFzmRuvJloznFjZrxBpMY+dIPBSOMFFLm+3L/ykC4+mmTTW8rTzeC3reVVg7aHAuh33t4Cxk6aSN2CBIEAuB4pHLBuQhq3rJmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860534; c=relaxed/simple;
	bh=PAbgegwPc3efHCTeUWxMzSWJ04cpHtXQQaOR5mra3mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gMPVImXXcdVbyPoU/lQu9JT3zQi2k2CEPDW8YkY3bXb4Zz3zxJP6vRascu3g0lea/W2GVJUtHqPgXDIXASyc96oK/KGfbAMM2YY6sWjHpGiZ0RtjFYhehxm8GIobphgQvtR4B+wPZZ9fgtYT6bzqasuSPBpeaKMEFkFES7bOdU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iQe4q/ut; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQe4q/ut"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778860531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S4DmGVTsafMsjgV0O8jAcH3MS4O8gNidxhAd+QZ6ueo=;
	b=iQe4q/utw2wn36hh0tS/A1672PmF/GqfM/KAVJPekM+4/rtmUp92o5s+Ts6LjswP7uy8VM
	qE0rKAJQp2uskaxIW5Ub5XFC2rIx+C45RG6sc+EeH0HDk+A2enuQUT2Ak0YwR4ThJSaUPN
	ZTWddzF31YEWxIz4tBRZFijjbMsud+k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-04ndNL1TNsK-uuDzJNUEmw-1; Fri,
 15 May 2026 11:55:30 -0400
X-MC-Unique: 04ndNL1TNsK-uuDzJNUEmw-1
X-Mimecast-MFC-AGG-ID: 04ndNL1TNsK-uuDzJNUEmw_1778860529
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC3751800371;
	Fri, 15 May 2026 15:55:28 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.80.107])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CD9F51956053;
	Fri, 15 May 2026 15:55:26 +0000 (UTC)
Date: Fri, 15 May 2026 12:55:25 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] verification/rvgen: Switch LTL parser to Lark
Message-ID: <agdBcW8_GTP3YuNs@wcosta-defaultstring.rmtbr.csb>
References: <cover.1777962130.git.namcao@linutronix.de>
 <85aaa8cacb31cfc78619a07aeae9a86d059a4cc1.1777962130.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <85aaa8cacb31cfc78619a07aeae9a86d059a4cc1.1777962130.git.namcao@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: _5BxycsAd_ROrUBFLJzKDFpkOCkVJ18dMaHewy3naI8_1778860529
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 05, 2026 at 08:59:22AM +0200, Nam Cao wrote:
> The LTL parser is built using Ply. However, Ply is no longer
> maintained [1].
> 
> Switch to use Lark instead. In addition to being actively maintained, Lark
> also offers additional features (namely, automatically creating the
> abstract syntax tree) which make the parser simpler.
> 
> Link: https://github.com/dabeaz/ply/commit/9d7c40099e23ff78f9d86ef69a26c1e8a83e706a [1]
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  tools/verification/rvgen/rvgen/ltl2ba.py | 189 +++++++++--------------
>  1 file changed, 70 insertions(+), 119 deletions(-)
> 
> diff --git a/tools/verification/rvgen/rvgen/ltl2ba.py b/tools/verification/rvgen/rvgen/ltl2ba.py
> index 7f538598a868..b2dee2dbe257 100644
> --- a/tools/verification/rvgen/rvgen/ltl2ba.py
> +++ b/tools/verification/rvgen/rvgen/ltl2ba.py
> @@ -7,8 +7,7 @@
>  # https://doi.org/10.1007/978-0-387-34892-6_1
>  # With extra optimizations
>  
> -from ply.lex import lex
> -from ply.yacc import yacc
> +import lark
>  from .automata import AutomataError
>  
>  # Grammar:
> @@ -30,42 +29,38 @@ from .automata import AutomataError
>  #       imply
>  #       equivalent
>  
> -tokens = (
> -   'AND',
> -   'OR',
> -   'IMPLY',
> -   'UNTIL',
> -   'ALWAYS',
> -   'EVENTUALLY',
> -   'NEXT',
> -   'VARIABLE',
> -   'LITERAL',
> -   'NOT',
> -   'LPAREN',
> -   'RPAREN',
> -   'ASSIGN',
> -)
> -
> -t_AND = r'and'
> -t_OR = r'or'
> -t_IMPLY = r'imply'
> -t_UNTIL = r'until'
> -t_ALWAYS = r'always'
> -t_NEXT = r'next'
> -t_EVENTUALLY = r'eventually'
> -t_VARIABLE = r'[A-Z_0-9]+'
> -t_LITERAL = r'true|false'
> -t_NOT = r'not'
> -t_LPAREN = r'\('
> -t_RPAREN = r'\)'
> -t_ASSIGN = r'='
> -t_ignore_COMMENT = r'\#.*'
> -t_ignore = ' \t\n'
> -
> -def t_error(t):
> -    raise AutomataError(f"Illegal character '{t.value[0]}'")
> -
> -lexer = lex()
> +GRAMMAR = r'''
> +start: assign+
> +
> +assign: VARIABLE "=" _ltl
> +
> +_ltl: _opd | binop | unop
> +
> +_opd : VARIABLE
> +     | LITERAL
> +     | "(" _ltl ")"
> +
> +unop: UNOP _ltl
> +UNOP: "always"
> +     | "eventually"
> +     | "next"
> +     | "not"
> +
> +binop: _opd BINOP _ltl
> +BINOP: "until"
> +      | "and"
> +      | "or"
> +      | "imply"
> +
> +VARIABLE: /[A-Z_0-9]+/

Is it ok to start variable names with a number? (unless I am reading the
regex wrong).

> +LITERAL: "true" | "false"
> +
> +COMMENT: "#" /.*/ "\n"
> +%ignore COMMENT
> +
> +%import common.WS
> +%ignore WS
> +'''
>  
>  class GraphNode:
>      uid = 0
> @@ -432,90 +427,46 @@ class Literal:
>          node.old |= {n}
>          return node.expand(node_set)
>  
> -def p_spec(p):
> -    '''
> -    spec : assign
> -         | assign spec
> -    '''
> -    if len(p) == 3:
> -        p[2].append(p[1])
> -        p[0] = p[2]
> -    else:
> -        p[0] = [p[1]]
> -
> -def p_assign(p):
> -    '''
> -    assign : VARIABLE ASSIGN ltl
> -    '''
> -    p[0] = (p[1], p[3])
> -
> -def p_ltl(p):
> -    '''
> -    ltl : opd
> -        | binop
> -        | unop
> -    '''
> -    p[0] = p[1]
> -
> -def p_opd(p):
> -    '''
> -    opd : VARIABLE
> -        | LITERAL
> -        | LPAREN ltl RPAREN
> -    '''
> -    if p[1] == "true":
> -        p[0] = ASTNode(Literal(True))
> -    elif p[1] == "false":
> -        p[0] = ASTNode(Literal(False))
> -    elif p[1] == '(':
> -        p[0] = p[2]
> -    else:
> -        p[0] = ASTNode(Variable(p[1]))
> -
> -def p_unop(p):
> -    '''
> -    unop : ALWAYS ltl
> -         | EVENTUALLY ltl
> -         | NEXT ltl
> -         | NOT ltl
> -    '''
> -    if p[1] == "always":
> -        op = AlwaysOp(p[2])
> -    elif p[1] == "eventually":
> -        op = EventuallyOp(p[2])
> -    elif p[1] == "next":
> -        op = NextOp(p[2])
> -    elif p[1] == "not":
> -        op = NotOp(p[2])
> -    else:
> -        raise AutomataError(f"Invalid unary operator {p[1]}")
> -
> -    p[0] = ASTNode(op)
> -
> -def p_binop(p):
> -    '''
> -    binop : opd UNTIL ltl
> -          | opd AND ltl
> -          | opd OR ltl
> -          | opd IMPLY ltl
> -    '''
> -    if p[2] == "and":
> -        op = AndOp(p[1], p[3])
> -    elif p[2] == "until":
> -        op = UntilOp(p[1], p[3])
> -    elif p[2] == "or":
> -        op = OrOp(p[1], p[3])
> -    elif p[2] == "imply":
> -        op = ImplyOp(p[1], p[3])
> -    else:
> -        raise AutomataError(f"Invalid binary operator {p[2]}")
> -
> -    p[0] = ASTNode(op)
> -
> -parser = yacc()
> +class Transform(lark.visitors.Transformer):
> +    def unop(self, node):
> +        if node[0] == "always":
> +            return ASTNode(AlwaysOp(node[1]))
> +        if node[0] == "eventually":
> +            return ASTNode(EventuallyOp(node[1]))
> +        if node[0] == "next":
> +            return ASTNode(NextOp(node[1]))
> +        if node[0] == "not":
> +            return ASTNode(NotOp(node[1]))
> +        raise ValueError("Unknown operator %s" % node[1])
> +
> +    def binop(self, node):
> +        if node[1] == "until":
> +            return ASTNode(UntilOp(node[0], node[2]))
> +        if node[1] == "and":
> +            return ASTNode(AndOp(node[0], node[2]))
> +        if node[1] == "or":
> +            return ASTNode(OrOp(node[0], node[2]))
> +        if node[1] == "imply":
> +            return ASTNode(ImplyOp(node[0], node[2]))
> +        raise ValueError("Unknown operator %s" % node[1])
> +
> +    def VARIABLE(self, args):
> +        return ASTNode(Variable(args))
> +
> +    def LITERAL(self, args):
> +        return ASTNode(Variable(args))

shouldn't this be `return ASTNode(Literal(args) == "true")`?

> +
> +    def start(self, node):
> +        return node
> +
> +    def assign(self, node):
> +        return node[0].op.name, node[1]
> +
> +parser = lark.Lark(GRAMMAR)
>  
>  def parse_ltl(s: str) -> ASTNode:
>      spec = parser.parse(s)
> +    spec = Transform().transform(spec)
>  
>      rule = None
>      subexpr = {}
> -- 
> 2.47.3
> 

