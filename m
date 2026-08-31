Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0210282F16;
	Mon, 31 Aug 2026 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174881; cv=none; b=aoulsn/GPmLuJ/eGr3pK4V/k2a35etic/E/N+cRzAQZTyN3XCoVCBT26i+jNpZBHDZS9aodmYxcluR9JLjPnVwjru27e86AvM0xmxgRbvJI79/2TLds7o4Dn0LGvfsm0+nuHJXuv2LAG1isEMK5wW4rsPM65s0kpiUZ0rgiI+nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174881; c=relaxed/simple;
	bh=Tw4x6gsRlbVaMi0CbGyS+OI39ihR68Xuj34Qz4n9YAA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=kAExpXmuMkdrZeX/aXLFxIEMHv/12wBWB9wpykrS9RUAbkerewJfCvb720TrHyTM1vxcQYgv2R+iOycMlUAYlAN6MPEbIaCFj+EJUeItm5tsawU8idoPeyuKvQ5t2jr7FJdRoSrSb5ZH3RLuzkJQEOWJM4Ahyx6eivGNMmm/MJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=KRNAXEb6; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=3JfnXYbc; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="KRNAXEb6";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="3JfnXYbc"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788174856; bh=WI7kZU7t2YsK4h1529X3bPL
	iXmEgLLBd35poCRRGafw=; b=KRNAXEb6rx1a45UOaASceH/kGHm5VZnyEDSpoLaxx2+boG7MWe
	T/rmKvq/jBUaOv3MrpxToXGbi4nUE2JkJa95XOnC3HUt55igN0pa6VTpEjEK41tI00aB8vihUQH
	o+U3gRQSfAfwZGWkUdUv7wVaMb8w4l8deyjtBez4yzQ48+MDm1fm3PfFXDobds0lqjyu2vYGblw
	GtwbLeFtcUf4JuWE4v969HvHtpbRo7zv+v4CBRZmQwj1/5wk/g8e91pz/isOnBCRqQNsuXQ+Jxm
	tiqB6g7qWTTJt7bJFQY9lp5BhHn4iMy3jMXiw/p7mGBQ8lK8QAAspw+gn+o3BqWTjlw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788174856; bh=WI7kZU7t2YsK4h1529X3bPL
	iXmEgLLBd35poCRRGafw=; b=3JfnXYbcR67Jm75CsqG/hV0fftiWhRIMdPyqpUBegyp+4TCIgW
	mTPGjSUcaVMJBO3fGDXoqM7YAmKCip3zfPBg==;
Date: Mon, 31 Aug 2026 12:14:17 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-usb@vger.kernel.org, driver-core@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 1/2] module: pull out add_taint_module() to be public
In-Reply-To: <2026083120-matrix-waffle-7ee7@gregkh>
References: <20260831-bind_taint-v2-0-1082d631213b@linuxfoundation.org> <20260831-bind_taint-v2-1-1082d631213b@linuxfoundation.org> <2026083120-matrix-waffle-7ee7@gregkh>
Message-ID: <A47FDF4A-DA90-4015-AFDB-61CA611F6311@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 31 August 2026 12:07:50 BST, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>On Mon, Aug 31, 2026 at 12:51:46PM +0200, Greg Kroah-Hartman wrote:
>> Other kernel code might want to call add_taint_module() so pull it out
>> and make it global.  If modules are not enabled, this defaults to a call
>> to add_taint(), so all is fine.
>> 
>> Reviewed-by: Johan Hovold <johan@kernel.org>
>> Tested-by: Johan Hovold <johan@kernel.org>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>  include/linux/module.h | 10 ++++++++++
>>  kernel/module/main.c   | 16 +++++++++++++---
>>  2 files changed, 23 insertions(+), 3 deletions(-)
>> 
>> diff --git a/include/linux/module.h b/include/linux/module.h
>> index 96cc98568eea..0636e0f2728c 100644
>> --- a/include/linux/module.h
>> +++ b/include/linux/module.h
>> @@ -29,6 +29,7 @@
>>  #include <linux/srcu.h>
>>  #include <linux/static_call_types.h>
>>  #include <linux/dynamic_debug.h>
>> +#include <linux/panic.h>
>>  
>>  #include <linux/percpu.h>
>>  #include <asm/module.h>
>> @@ -770,6 +771,9 @@ static inline bool is_livepatch_module(struct module
>*mod)
>>  
>>  void module_for_each_mod(int(*func)(struct module *mod, void *data),
>void *data);
>>  
>> +void add_taint_module(struct module *mod, unsigned flag,
>> +		      enum lockdep_ok lockdep_ok);
>> +
>>  #else /* !CONFIG_MODULES... */
>>  
>>  static inline struct module *__module_address(unsigned long addr)
>> @@ -877,6 +881,12 @@ static inline bool module_is_coming(struct module
>*mod)
>>  static inline void module_for_each_mod(int(*func)(struct module *mod,
>void *data), void *data)
>>  {
>>  }
>> +
>> +static inline void add_taint_module(struct module *mod, unsigned flag,
>> +				    enum lockdep_ok, lockdep_ok)
>
>And this line is wrong, ugh.  I gotta go get sashiko running locally...

Cough cough, Claude code speaking 

>
>There will be a v3 in a few days.
>
>greg k-h

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
