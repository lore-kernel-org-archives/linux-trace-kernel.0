Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5B8CA6B;
	Thu, 10 Sep 2026 00:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788998467; cv=none; b=CsSkh0KMUebjeYvAn6hoSQ6Dt89Zth3TfVQsKG5eFkSJtPRwDT/goM9fK1Cxv0cG5YNEA5RkVzZTgs/mp+2bX2SgrrVen7+6Ry5riOT3LSQKECWg14rjQVNTj4or93cec9Ox9+EA+jUrt3BJLFhf4ZSxXTQfEVylh/yy0eHMDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788998467; c=relaxed/simple;
	bh=OMU8A5Ao2vJA9l52y1pszwIUhaM632Tt+NqriLJ2ZGA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Qg9bEwT43jIxToMTxRhwotKGzH00SQyM3KSe93T1Br9pWs24cCFWqVRMA1oyQ9OnSz39w0PJ8d8ly4FxtfE3W9L4x5gGsd7BfEZtWnel1ZCeUeJMpz4ISycQfR1sEsy6lznn1WeFPHXC7SmTriZznow9QW/zbzftySPeCPGGNeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgbcjTgE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgbcjTgE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552261F000FF;
	Thu, 10 Sep 2026 00:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788998466;
	bh=bA2EBsGvtwkWzRL0EMLdqaw14JhPYVO1zwoXiTZVb5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SgbcjTgE/bZQnQ6CwRAw9MyhxAX3oF4XATZ7JKlTqYVmOpR6LUi23TaBD/XLLdNNM
	 VvD4w1JoieN7uYWBH0ovjDvW3t+AXOUt53X0SF9p5FB8GK3BwybSygtVp9HuOoF2fh
	 ljFC7TI/v3kBnMCARiqoaE286HSW9AF69U7qtW+m8hcvLA05rx/01T8wzPyvJcyt+M
	 YEHhGgBsPGV3bCDAM4UZlLyp5WW5NPcC/7n9iltn/XJMb0vFgFF9Yn7e1dNg0Wc0Dg
	 F8PgkHd57CViAeLctuSNk+dojp8ohachDLBAah2XqrP49bsrI3vKdoE+4PpnLyHxTF
	 1cAS9AtMz8sKA==
Date: Thu, 10 Sep 2026 09:01:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sven Schnelle <svens@linux.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Fix unique symbol check in
 kprobe_non_uniq_symbol.tc
Message-Id: <20260910090102.5ba6c7993bc0a7bf1fbc4426@kernel.org>
In-Reply-To: <20260909134156.6425e8b0@gandalf.local.home>
References: <20260909092954.2200558-1-svens@linux.ibm.com>
	<20260909134156.6425e8b0@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Sep 2026 13:41:56 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed,  9 Sep 2026 11:29:53 +0200
> Sven Schnelle <svens@linux.ibm.com> wrote:
> 
> > The current regex also matches symbols in modules, which makes the
> > test fail on s390 where name_show is present only once in the kernel,
> > but also multiple times in modules:
> > 
> > 000001b1401cdc20 t name_show
> > 000001b0c05e6c40 t name_show    [mdev]
> > 000001b0c0495f30 t name_show    [i2c_core]
> > 
> > Fix this by changing the regular expression to only match the function
> > name.
> > 
> > Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> > ---
> >  .../selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc    | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
> > index bc9514428dba..07b1177c1634 100644
> > --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
> > @@ -6,7 +6,7 @@
> >  SYMBOL='name_show'
> >  
> >  # We skip this test on kernel where SYMBOL is unique or does not exist.
> > -if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}" /proc/kallsyms)" -le '1' ]; then
> > +if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}$" /proc/kallsyms)" -le '1' ]; then
> >  	exit_unsupported
> >  fi
> >  
> 
> Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
> 
> But I wonder if "type_show" or "init_once" is a better option than
> "name_show"?

Yeah, we have many other candidates :)

$ grep -E '[[:alnum:]]+ t [[:alpha:]][[:alnum:]_]+$' /proc/kallsyms | cut -d " " -f 3  | sort | uniq -cd | sort -nr | head 
     27 p4d_offset
     20 type_show
     20 dev_attr_name
     17 dev_attr_modalias
     16 pfn_to_mfn
     15 name_show
     14 modalias_show
     14 dev_attr_type
     13 init_once
     13 format_attr_event

Maybe we can just fallback to this logic for finding available symbols?

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
