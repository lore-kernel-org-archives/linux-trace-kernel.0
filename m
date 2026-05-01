Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4316F3F2119;
	Fri,  1 May 2026 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777652485; cv=none; b=fDnuevQ5Nf+UqY25ChZGGKZGQCpntQ3L4bi9761neNUnaHeuk742KMtwodkZm+0TP1vbg3SM3VJFfTAGx1gq6IrJhbdSlnGTuw+VOmojAoTDXk9alUQaYcPitkhMhbXBiv8LQ14Gb38k5Mdl4swAmFvDBnc3NFvgE80Bwk986X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777652485; c=relaxed/simple;
	bh=j+FgJTljU+MKHYfS7zpPFoQ4ZjUqvtdGRbsZ4NLIkE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUcaCzRRpdR7fT/SrDiwqT4y2j/dzjDmt1iKaB9dluxHgWwgwssUFYE+s6/vx0z6xC02jxJnrIyl/AlqCObvgjIrRX3dLi1yEU0pO1B0gysPqcwlO4fL8mTeEcasbCDir9b6CSG383vZa2aNrtTZOHSq4xKv74o1JMtcoDE3jV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id C5AB31601A9;
	Fri,  1 May 2026 16:21:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 06C8B2002C;
	Fri,  1 May 2026 16:21:04 +0000 (UTC)
Date: Fri, 1 May 2026 12:21:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Qian-Yu Lin <tiffany019230@gmail.com>
Cc: mhiramat@kernel.org, david.laight.linux@gmail.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] trace_printk: replace _______STR with __UNIQUE_ID(STR)
Message-ID: <20260501122106.2c2076e0@gandalf.local.home>
In-Reply-To: <afTSLgFwpYW1py36@nova>
References: <20260429165707.7020-1-tiffany019230@gmail.com>
	<20260429134226.49e95e9d@robin>
	<afS7UUAfzgiSzEHv@nova>
	<20260501111939.0536140a@gandalf.local.home>
	<afTSLgFwpYW1py36@nova>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 06C8B2002C
X-Rspamd-Server: rspamout06
X-Stat-Signature: dkc716zwyyme8xg8373rxrpzaw99cnfn
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/3kRqBaq/wvoIZ4aA1KooYv8ZhyfAiAi8=
X-HE-Tag: 1777652464-518502
X-HE-Meta: U2FsdGVkX1/eP0arGETJ36IwMqa1+b9sQ50E3MnbJRbW2f/Rz9gym3O+4+iSt0LU9+rsqCAHdV5ABN3ZIO7X3HRQi9OGLyGwoq5TfcPLsWunN+fEQbtXsBBpaGyEBrrN2hKL1f8txdspH18r62DZhXcTFa+jko22K1yf2WyO7AArLFZA2+rS1wpqGQBMavK9IFPZUekOoI0TSBIqX1z1M0jhMDtrj6NIgqqPoXe15MPXz12vrci9moo94CBDuiM68lF3INvLfe/msHkoJr/T/CMeZfpbO0lHagTTLfoSzkMiQKcabt//tU/Zwc5J840dedT7q1lQCMeUFSufexcVt+RInf/Ov45C

On Sat, 2 May 2026 00:17:50 +0800
Qian-Yu Lin <tiffany019230@gmail.com> wrote:

> Yes, I verified it with the preprocessor output. I created a minimal
> test file:
> 
> // kernel/trace/test_trace_printk.c
> #include <linux/trace_printk.h>
> 
> void test(void) {
>     trace_printk("no args\n");
>     trace_printk("with arg %d\n", 42);
> }
> 
> Then ran make kernel/trace/test_trace_printk.i.
> 
> The no-args case has sizeof((char[]){"()"}) which is 3, so 3 > 3 is
> false and it falls through to trace_bputs/trace_puts.
> 
> The args case has sizeof((char[]){"(42)"}) which is 5, so 5 > 3 is
> true and it goes to trace_bprintk/trace_printk with the argument
> 42 correctly passed through.

Thanks. When I test, I do the same but just compile down to an object file
and run objdump and look at which functions were called.

-- Steve
