Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523B027A465;
	Wed,  4 Feb 2026 23:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770246787; cv=none; b=XwIc1RoYHTHY5wvJGm9O3+okUQvD1glGlDXVeS90ZXn+ZhLRV6quZnbjUU0le4TbmFIJN7OkumTuJ/LFOJ+Wnk7rvjs51nC29VCSg0Gehjre1jAHk2mNPGAdnpA+ESIUUTjHlz7hwqLjvY+aEBMbOR/v5Vp7SLCrWgwniBI+bss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770246787; c=relaxed/simple;
	bh=04FZPl+W3thENnw4l3ZT5Fs5noSB0k/lZLr2vI0J6H4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KPtQKgYnGttg/x4Vb609NCEJqM3HGkF58Qgqzy4jtWELoIg4X+hvjxnMzgu4UKAKMEcDtM3wr281VXAmLgwKEOSNfqU7m84BoQoz1NyXnui6iRbNug4KfDLzuCvB8oHA084brPGcSSaU/DNMSxz51Lg49/6TH8OAoPgZhnqZre8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nueV5W6L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nueV5W6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEE4C4CEF7;
	Wed,  4 Feb 2026 23:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770246786;
	bh=04FZPl+W3thENnw4l3ZT5Fs5noSB0k/lZLr2vI0J6H4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nueV5W6LNVYM1eWIAJ32tuUP/B2H3CovmvB3ND23JM8/37l1sPx22AYBMtw4VZwIs
	 vGtWylAF6OdW5AgVFinoMeZ47j59Mt+jqBxYHKQeJg4rR84v5V2CLGtCKc39/u9OfP
	 idpeKL1ZSc5QTYkVQpZZaCUeBj/kOImItHzABstH+RkCIMKOJUHgeZb9VMCTvpFc4x
	 sSb7edYJrOkpXWJ1TZWBCIFJcMgaapinAdwtwz/pKECRrH7q/SpNHk02L30zJ/z6wK
	 SOJtYHaxZ2y1NY70jDZLdW5aZDrauGKC621numKoGkR/Wi+vCg0SySoSF9YdTdv3gL
	 uOno1hrqqak7Q==
Date: Thu, 5 Feb 2026 08:13:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, Julius Werner <jwerner@google.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] bootconfig: Terminate value search if it hits a
 newline
Message-Id: <20260205081303.384f3845c7c1f40551e6fbcc@kernel.org>
In-Reply-To: <20260204172057.5bcbfcfd@gandalf.local.home>
References: <177019401833.80694.554894321526842218.stgit@devnote2>
	<177019402883.80694.10977484286951965499.stgit@devnote2>
	<20260204172057.5bcbfcfd@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Feb 2026 17:20:57 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed,  4 Feb 2026 17:33:48 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Terminate the value search for a key if it hits a newline and make
> > the value empty.
> > 
> > When we pass a bootconfig with an empty value terminated by the
> > newline, like below::
> > 
> >   foo =
> >   bar = value
> > 
> > Current bootconfig interprets it as a single entry::
> > 
> >   foo = "bar = value";
> > 
> > The Documentation/admin-guide/bootconfig.rst defines the value
> > itself is terminated by newline:
> > 
> >   The value has to be terminated by semi-colon (``;``) or newline (``\n``).
> > 
> > but it does not define when the value search is terminated.
> > This changes the behavior to more line-oriented, so that it can
> 
>      to be more line-oriented
> 
> > clear how it is working.
> 
>   so that it is clearer in how it works.
> 

OK,

> 
> > 
> > - The value search of key-value pair will be terminated by a comment
> >   or newline.
> > - The value search of an array will continue beyond comments and
> >   newlines.
> > 
> > Thus, with this update, the above example is interpreted as::
> > 
> >   foo = "";
> >   bar = "value";
> > 
> > And the below example will cause a syntax error because "bar" is expected
> > as a key but it has ','.
> > 
> >   foo =
> >     bar, buz
> > 
> > According to this change, one wrong example config is updated.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v2:
> >   - Fix to handle multi-line array case correctly.
> >   - Make this as a spec update, not fix.
> > ---
> >  .../samples/good-array-space-comment.bconf         |    3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> > index 7a86042c9b6d..843b24b8de88 100644
> > --- a/Documentation/admin-guide/bootconfig.rst
> > +++ b/Documentation/admin-guide/bootconfig.rst
> > @@ -20,18 +20,26 @@ Config File Syntax
> >  
> >  The boot config syntax is a simple structured key-value. Each key consists
> >  of dot-connected-words, and key and value are connected by ``=``. The value
> > -has to be terminated by semi-colon (``;``) or newline (``\n``).
> > -For array value, array entries are separated by comma (``,``). ::
> > -
> > -  KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
> > -
> > -Unlike the kernel command line syntax, spaces are OK around the comma and ``=``.
> > +string has to be terminated by the following delimiters described below.
> >  
> >  Each key word must contain only alphabets, numbers, dash (``-``) or underscore
> >  (``_``). And each value only contains printable characters or spaces except
> >  for delimiters such as semi-colon (``;``), new-line (``\n``), comma (``,``),
> >  hash (``#``) and closing brace (``}``).
> >  
> > +If the ``=`` is followed by whitespace up to one of these delimiters, the
> > +key is assigned an empty value.
> > +
> > +For arrays, the array values are comma (``,``) separated, and comments and
> > +line breaks with newline (``\n``) are allowed between array values for
> > +readability. Thus the first entry of the array must be the same line of the
> 
>                          must be on the same line as the key.

OK.

> 
> > +key.::
> > +
> > +  KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
> > +
> > +Unlike the kernel command line syntax, white spaces (including tabs) are
> > +ignored around the comma and ``=``.
> > +
> >  If you want to use those delimiters in a value, you can use either double-
> >  quotes (``"VALUE"``) or single-quotes (``'VALUE'``) to quote it. Note that
> >  you can not escape these quotes.
> > @@ -138,8 +146,8 @@ This is parsed as below::
> >   foo = value
> >   bar = 1, 2, 3
> >  
> > -Note that you can not put a comment between value and delimiter(``,`` or
> > -``;``). This means following config has a syntax error ::
> > +Note that you can NOT put a comment or a newline between value and delimiter
> > +(``,`` or ``;``). This means following config has a syntax error ::
> >  
> >   key = 1 # comment
> >         ,2
> > diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> > index 81f29c29f47b..c210fb8b1e85 100644
> > --- a/lib/bootconfig.c
> > +++ b/lib/bootconfig.c
> > @@ -557,17 +557,13 @@ static int __init __xbc_close_brace(char *p)
> >  /*
> >   * Return delimiter or error, no node added. As same as lib/cmdline.c,
> >   * you can use " around spaces, but can't escape " for value.
> > + * *@__v must point real value string. (not including spaces before value.)
> >   */
> >  static int __init __xbc_parse_value(char **__v, char **__n)
> >  {
> >  	char *p, *v = *__v;
> >  	int c, quotes = 0;
> >  
> > -	v = skip_spaces(v);
> > -	while (*v == '#') {
> > -		v = skip_comment(v);
> > -		v = skip_spaces(v);
> > -	}
> >  	if (*v == '"' || *v == '\'') {
> >  		quotes = *v;
> >  		v++;
> > @@ -617,6 +613,13 @@ static int __init xbc_parse_array(char **__v)
> >  		last_parent = xbc_node_get_child(last_parent);
> >  
> >  	do {
> > +		/* Search the next array value beyond comments and empty lines */
> > +		next = skip_spaces(*__v);
> > +		while (*next == '#') {
> > +			next = skip_comment(next);
> > +			next = skip_spaces(next);
> > +		}
> > +		*__v = next;
> >  		c = __xbc_parse_value(__v, &next);
> >  		if (c < 0)
> >  			return c;
> > @@ -701,9 +704,17 @@ static int __init xbc_parse_kv(char **k, char *v, int op)
> >  	if (ret)
> >  		return ret;
> >  
> > -	c = __xbc_parse_value(&v, &next);
> > -	if (c < 0)
> > -		return c;
> > +	v = skip_spaces_until_newline(v);
> > +	/* If there is a comment, this has an mpty value. */
> 
>                                              empty value

Thanks!

> 
> -- Steve
> 
> > +	if (*v == '#') {
> > +		next = skip_comment(v);
> > +		*v = '\0';
> > +		c = '\n';
> > +	} else {
> > +		c = __xbc_parse_value(&v, &next);
> > +		if (c < 0)
> > +			return c;
> > +	}
> >  
> >  	child = xbc_node_get_child(last_parent);
> >  	if (child && xbc_node_is_value(child)) {
> > diff --git a/tools/bootconfig/samples/good-array-space-comment.bconf b/tools/bootconfig/samples/good-array-space-comment.bconf
> > index 45b938dc0695..416fa2ed4109 100644
> > --- a/tools/bootconfig/samples/good-array-space-comment.bconf
> > +++ b/tools/bootconfig/samples/good-array-space-comment.bconf
> > @@ -1,4 +1,3 @@
> > -key =	# comment
> > -	"value1",	  # comment1
> > +key = "value1",	  # comment1
> >  	"value2"	 , # comment2
> >  	"value3"
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
