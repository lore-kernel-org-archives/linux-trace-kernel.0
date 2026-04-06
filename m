Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6852DA76A;
	Mon,  6 Apr 2026 01:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775437890; cv=none; b=Uyh6E3FChmuFWDyeH+cxU+YwxhzymX9Yq88zCYjZdzycEHCqyaFXmaG8kxMp3824K9bT0828tNGBe2O+ScKJcgE3jjyy0fC3AbXq3/657gfXtLTimKwghwsDeiymckujH6EYnEmWZiOT/A9haV0WqSnxfyzVfeuZohxlUBcWZIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775437890; c=relaxed/simple;
	bh=dFVKzIB/kqkkPC1g6Y+GR2MdhVAhC7i7xjW8RnruD5k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EPnnHRCd75NwtDZFrWxwSoj8p6QIsQV3aPIYpJQDI9abmKZp48wjdkclhbTF60J1qqChMnqua3fMiZYHTd9vAUmmhCwXpLVgzjrHj40CWBhszkE5qYyeMhFKB7OjKTt3odyS1ifFosMRIf3sPM2ylhsEOfLXBRmbnRW1unS5NlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqqAjo1M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqqAjo1M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA08C116C6;
	Mon,  6 Apr 2026 01:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775437889;
	bh=dFVKzIB/kqkkPC1g6Y+GR2MdhVAhC7i7xjW8RnruD5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KqqAjo1M0w7l379VMO9uC+pyHI+Du8oINvJw1C3b6Dd51HKpPKtESLVG2ZOQHjTGG
	 Qkr1yEB6d+0eCSnzp8n7uTMTHBR6hzCHtP8TwXzBhdvJgWsVrwXdjTPJ/XnVTDi3Bs
	 19IjrsSHKJX12kOKCtxG24qz90L0Vs9E+bJKIkNwtGFwn9v0X1v8RS8/dPgg/c1FMm
	 sfXkOg7N2V5FCSKMg+4tuWYY4wQ3VcqXdMJUa07bof3ZWnj4k94SUjHAC43lbMTvCi
	 lkp9cCIdXoQ/sJpL7iKXS159owTHRn2kfFU/0XIQmjnrvxJZQ86wZmumFmCYvr/53D
	 5hZDY5DHu47Sw==
Date: Mon, 6 Apr 2026 10:11:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/probe: reject empty immediate strings
Message-Id: <20260406101124.e4e5af12634fb1136cd7d132@kernel.org>
In-Reply-To: <20260404093359.e3bc3f7ededeba6a73858e5d@kernel.org>
References: <20260330062920.40766-1-pengpeng@iscas.ac.cn>
	<20260401160315.88518-1-pengpeng@iscas.ac.cn>
	<20260404093359.e3bc3f7ededeba6a73858e5d@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Sat, 4 Apr 2026 09:33:59 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index e0a5dc86c07e..e1c73065dae5 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -1068,7 +1068,7 @@ static int __parse_imm_string(char *str, char **pbuf, int offs)
> >  {
> >  	size_t len = strlen(str);
> >  
> > -	if (str[len - 1] != '"') {

It seems that this is not correct fix, because __parse_imm_string()
is only called from below code:

	case '\\':	/* Immediate value */
		if (arg[1] == '"') {	/* Immediate string */
			ret = __parse_imm_string(arg + 2, &tmp, ctx->offset + 2);
			if (ret)

Thus the call-site already checked the double-quotation.
This means this if block itself is meaningless.

Thanks,

> > +	if (!len || str[len - 1] != '"') {
> >  		trace_probe_log_err(offs + len, IMMSTR_NO_CLOSE);
> >  		return -EINVAL;
> >  	}
> > -- 
> > 2.50.1 (Apple Git-155)
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
