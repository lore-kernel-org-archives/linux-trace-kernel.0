Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29873C198A;
	Wed, 15 Jul 2026 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101126; cv=none; b=orgsnQn3/yCdyvelsZV0ZYvuR0uuMA6s3Mh1MFGHJcPyXN89emGLNDWbIrbXtwGd0tyXdG+mRucIqug5DfJ2Hsp4UCAWqkfiISR4tBLLNWA9roKBgjrzkkU6zXma5jEnOtKgjAVVhODwZOdUEIR3QuirVtaoH78KlXyuNRx/CLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101126; c=relaxed/simple;
	bh=XSRRLwolK3xoZ+k/7/FUhEpWRce7+QI7JVMV8Kh3KfE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rzMYLwblleGTbCiz/9Cvx400pcDdhK06jmG4ES069fM42T4ShS7nDaxxP8d9yzm2rySi4i7tx2742pwfekE5u8GrLM+P4OA3e8XJgrndmvyOlZrQbYR6AYvuL5w1dChjpLJ5lmTthiLVEAOCYDm5x1qP5msmyluFKfZMEVxPiFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=xCT+In72; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gzlkiJd8; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="xCT+In72";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gzlkiJd8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id DE26FEC0139;
	Wed, 15 Jul 2026 03:38:43 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Wed, 15 Jul 2026 03:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784101123;
	 x=1784187523; bh=ExRSIByqaOkUS6AX7i0RcHic5dXGvj4bnAtuT0fQZ/0=; b=
	xCT+In72hTc0d/arkvcmP371r6VFMDsOH53mEj3YaNvh0OTyNxi6vFs7+qTYwiQn
	16jQThKxnajs63xyeNyy38UoAvfUnOuPBxTztp+gZD/Zd875qvUe2/Vn6qkllu4i
	FCy8BcDiEXkFzKmGUL3VwDKz+IxbAtrYQY1T4G3R3tHD/+dZW1AtLoSE5aIFM3op
	smXiAIvR9wvTpkSZeWjQZx1emrv64FqIzJMtzovoz0rw1DnVHhlBPG/sPjjMF9NW
	6tnLx3neKrekJ8ddX0tY/Ut1RV3Uk/GTTkKC4piW5duo6/2khgEB3D9BaX985YAl
	QwxAc9enLOYODUIWUfs1Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784101123; x=
	1784187523; bh=ExRSIByqaOkUS6AX7i0RcHic5dXGvj4bnAtuT0fQZ/0=; b=g
	zlkiJd8MuEzBgALCY3LAQq1LrjrFzSHDasvX5jxWI/r/uTOfQPi4E/YNAAngl64u
	TRaFxFFxZztV1G/0VKCCeb7jdltTo21yPZJJZ3bfY8kaFy58zuoAT6WR6uzoPvQ4
	82JxjMfrfn3Sk0M4pHuoK8VvT11DVdEJFUO2Aao0cObGlDbRUp65Y7TUqR9UXzzd
	BaW9aiSsttcJSqShrwQlPh7/qDp5k8cA4P+C/KkzO4nLItc8DIoRUqLj8jEYkKm8
	oSrsg01vM3024bdzLHyHd4nfoWZrrwWCeHD7psMdk8qtu0j8b/MlaA6RDM/JNGR4
	mDmFnZw3cXKOt0ytWoRig==
X-ME-Sender: <xms:AzlXauy9neX8ITKPhDUTu9sZ-_Xyr8jN4IwA8ytJdNxT9uixQKF_Ag>
    <xme:AzlXalG56hWSeo83dv-JQaJNggknYDw7HowY8Q7liwkGABswbhJSG98LPyKtUZRUY
    Tm9BK6ySuyLNxGl76OnZLDtK4-oXH3442mL2hjkqZ3xIAJsCYCVHtc>
X-ME-Proxy-Cause: dmFkZTFc7hJUD3UEDARrx/iCvNX/XeS+ZefNUMDqqiB+RwQlreGU70zG672pw7wAm9kv9e
    LkbHflBAIfhzAcKrdZO4R025kHGqD+ozaXiawu+ga3eLDFbDUPNz3yDw7CzYEAsEHX6dYi
    lIh3MMIlqvLqrPLpEl+RKANlbmZrZvtYoVu90XD+97zPjYd/+5wuXpISNau1JRYMuTr0JH
    WWYAXzO470LuBktu4WgV1XGggC9FQs7DgdSMnt8zw1OzoZPRhzsrB07SQ23dPSICynxQ3l
    uGJx1smSuUTW+YhRyRv7lI/oHJJuMGTqAKYUUCrf2eALDOGoF6tqQ5jZd5d5/elSbYKiYk
    aJp4mwAFHc7L4eqijuZMIdw7GutqG1FX/vEQnK+ND7UYP9fglXt2ASXWZdo1xMJN7JMwrO
    h2XkHbMmBtLoeuqwxWU50buJGJPN9E1jmekYg4mNJsY32exUIaJ8enISlYJjJzYtExrTJ8
    h8FM8cb/Ug38YTacuy/PYXvHoIPpJU6hHnnXsgy08gA3Yb1OkgrER6xMfeO91X1Are2kWs
    3AKxr2cgEq+mocUs7Y6Yxo5r6NSGex9zcNkUWm78iaIi88bPITe3qnMxCqPNeUfjksbCod
    aMIswSagOK9vTjPq3bT4suoJOcbhN3DR9O+tsc94Zy/qWrdNDqRko5gAqvgg
X-ME-Proxy: <xmx:AzlXam3OWuULux3PSFdcjHPu1ius9xgyjjz7pbg3cTfxmBwR7JEOsg>
    <xmx:AzlXaphFRkNx05RUsecoS8pMnIfODkLtctTZ3ul7LySxvNZjMu4RcA>
    <xmx:AzlXauqhdSBA6flk3g0c1eKYONYy_yyZ2zNnPTDWK3IMjSxIHT4lKw>
    <xmx:AzlXakP81wePaNEjQrMwvAO_o5IoCH8SQR0Dr3ocuSZ57q2MHOXpwA>
    <xmx:AzlXanraP-Ajs9S6c9N3Emlj9GqB3gsOMLlLexmBd-yumPkkYJqKWOrY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 459371820082; Wed, 15 Jul 2026 03:38:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATTSxKVuwHDZ
Date: Wed, 15 Jul 2026 09:38:21 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Steven Rostedt" <rostedt@goodmis.org>,
 "Vincent Donnefort" <vdonnefort@google.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Marc Zyngier" <maz@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Paolo Bonzini" <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev
Message-Id: <cc1232f7-fa15-4e1b-ba24-3d77dcb813c9@app.fastmail.com>
In-Reply-To: <20260714175617.319a6ec7@gandalf.local.home>
References: <20260616164211.3733326-1-arnd@kernel.org>
 <ajKgjNuHUlteSziZ@google.com> <20260714175617.319a6ec7@gandalf.local.home>
Subject: Re: [PATCH] tracing: ring-buffer: allowlist clang-generated symbols
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jul 14, 2026, at 23:56, Steven Rostedt wrote:
> On Wed, 17 Jun 2026 14:26:36 +0100 Vincent Donnefort <vdonnefort@google.com> wrote:
>
>> On Tue, Jun 16, 2026 at 06:42:03PM +0200, Arnd Bergmann wrote:
>> > From: Arnd Bergmann <arnd@arndb.de>
>> > 
>> > In randconfig build testing using clang-22, I came across two
>> > sets of extra symbols in the ring buffer code that may get
>> > inserted by the compiler:
>> > 
>> > Unexpected symbols in kernel/trace/simple_ring_buffer.o:
>> >          U memset
>> > 
>> > Unexpected symbols in kernel/trace/simple_ring_buffer.o:
>> >                  U llvm_gcda_emit_arcs
>> >                  U llvm_gcda_emit_function
>> >                  U llvm_gcda_end_file
>> >                  U llvm_gcda_start_file
>> >                  U llvm_gcda_summary_info
>> >                  U llvm_gcov_init
>> > 
>> > Add all of these to the allowlist.
>> > 
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> > ---
>> >  kernel/trace/Makefile | 1 +
>> >  1 file changed, 1 insertion(+)
>> > 
>> > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
>> > index f934ff586bd4..aa8564fb8ff4 100644
>> > --- a/kernel/trace/Makefile
>> > +++ b/kernel/trace/Makefile
>> > @@ -146,6 +146,7 @@ KASAN_SANITIZE_undefsyms_base.o := y  
>> 
>> Would "GCOV_PROFILE_undefsyms_base.o := y" work?
>
> Arnd?

Yes, turning off gcov for this file should avoid the llvm_gcda and
llvm_gcov symbols, but not the memset() symbol.

All the other features that leave annotations are handled by
listing the symbol names (__asan __gcov __kasan __kcsan __hwasan
__sancov __sanitizer __tsan __ubsan __msan), so I think for
consistency it makes sense to treat llvm gcov the same way
we handle gcc gcov and the rest.

      Arnd
