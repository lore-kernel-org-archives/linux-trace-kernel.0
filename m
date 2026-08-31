Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660A03F39DC;
	Mon, 31 Aug 2026 11:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176326; cv=none; b=iU/a8zYL8bH3mx+wXQeLjBJkS6/p38S4TvbC/3rBs2UGQRs+rt2HxqjNWz5GYtkrRBxQ+LnwB1HkdSc00yrIXTET+sQTkf3kKn8t7wKotvoHToqBknyaKipNDDhxEhgv8+jXZjJkoo+Xjk3S1bawbus3hR7p7h99hB+uWhu+CxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176326; c=relaxed/simple;
	bh=nwOFeWvsaBX4TElxo8BKbmKNns0DJdUW18m7d+uWhnc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ThCyoSg+dJiF5q5+ReciUPnNru2X/NV9zgyGAt2MjnlPKauJmydOnSG595rZsJvbqriMo+TH5lkxRFEG73+idldJtwKxT+zsb/saoyn7vJnP0+LA6tcgUSS+9A5DThKhxdNdj7YfWV9MEwiEl5DL9epJLgFjUPrV6aSVqpAIQOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=dfFKL9ly; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=55bSVbf5; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="dfFKL9ly";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="55bSVbf5"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788176287; bh=9HqZxXcOW1Xz+TeJ5NTeoxc
	fysDQipXYrj2AUeLNun0=; b=dfFKL9lyz40RzeiWqHXXOCaIDqgwZ1htZdpeyMaBEy0PvVjJVu
	O2C8rvt8ORsvG29BGnpKvkeXtTj5EfmADXyEm+lQwzlx9k6in1w6Zi9K25Oa44YfHOd20AMyQnz
	2vmpKB7Xs4RuacxKM5cQf09axsoKhFz8Zkangyy8N2E3yhUBi1XFtTp0A7qcWqnziXps4jaAxEV
	nXEqziHG7t6I1zepHtrJ+6zue8J9Siy/+dmCIyFC+rlmBLEo4QFVkazKeZFpHSTbrwcmcziEmJJ
	wzrzfIKyVY5W7lOonPUnq5W2KEz6WBlkuMyzoyNp4LQGZMZv3Mr/1xr47biUIXcv4fw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788176287; bh=9HqZxXcOW1Xz+TeJ5NTeoxc
	fysDQipXYrj2AUeLNun0=; b=55bSVbf5AvgQD63tjCm5Ti7kRPi24HGf/KR7iTn9Mnol/gUT8g
	OzzaXlRRf/EfnCdf/4aPiANr0XnCdUJnlNCg==;
Date: Mon, 31 Aug 2026 12:38:07 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-usb@vger.kernel.org, driver-core@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 1/2] module: pull out add_taint_module() to be public
In-Reply-To: <2026083107-gently-leverage-7f97@gregkh>
References: <20260831-bind_taint-v2-0-1082d631213b@linuxfoundation.org> <20260831-bind_taint-v2-1-1082d631213b@linuxfoundation.org> <2026083120-matrix-waffle-7ee7@gregkh> <A47FDF4A-DA90-4015-AFDB-61CA611F6311@mainlining.org> <2026083107-gently-leverage-7f97@gregkh>
Message-ID: <F4CE5DE5-66B7-491C-B288-A5666A56FC0F@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 31 August 2026 12:28:48 BST, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>On Mon, Aug 31, 2026 at 12:14:17PM +0100, Bradley Morgan wrote:
>> On 31 August 2026 12:07:50 BST, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> >On Mon, Aug 31, 2026 at 12:51:46PM +0200, Greg Kroah-Hartman wrote:
>> >> Other kernel code might want to call add_taint_module() so pull it
>out
>> >> and make it global.  If modules are not enabled, this defaults to a
>call
>> >> to add_taint(), so all is fine.
>> >> 
>> >> Reviewed-by: Johan Hovold <johan@kernel.org>
>> >> Tested-by: Johan Hovold <johan@kernel.org>
>> >> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> >> ---
>> >>  include/linux/module.h | 10 ++++++++++
>> >>  kernel/module/main.c   | 16 +++++++++++++---
>> >>  2 files changed, 23 insertions(+), 3 deletions(-)
>> >> 
>> >> diff --git a/include/linux/module.h b/include/linux/module.h
>> >> index 96cc98568eea..0636e0f2728c 100644
>> >> --- a/include/linux/module.h
>> >> +++ b/include/linux/module.h
>> >> @@ -29,6 +29,7 @@
>> >>  #include <linux/srcu.h>
>> >>  #include <linux/static_call_types.h>
>> >>  #include <linux/dynamic_debug.h>
>> >> +#include <linux/panic.h>
>> >>  
>> >>  #include <linux/percpu.h>
>> >>  #include <asm/module.h>
>> >> @@ -770,6 +771,9 @@ static inline bool is_livepatch_module(struct
>module
>> >*mod)
>> >>  
>> >>  void module_for_each_mod(int(*func)(struct module *mod, void *data),
>> >void *data);
>> >>  
>> >> +void add_taint_module(struct module *mod, unsigned flag,
>> >> +		      enum lockdep_ok lockdep_ok);
>> >> +
>> >>  #else /* !CONFIG_MODULES... */
>> >>  
>> >>  static inline struct module *__module_address(unsigned long addr)
>> >> @@ -877,6 +881,12 @@ static inline bool module_is_coming(struct
>module
>> >*mod)
>> >>  static inline void module_for_each_mod(int(*func)(struct module
>*mod,
>> >void *data), void *data)
>> >>  {
>> >>  }
>> >> +
>> >> +static inline void add_taint_module(struct module *mod, unsigned
>flag,
>> >> +				    enum lockdep_ok, lockdep_ok)
>> >
>> >And this line is wrong, ugh.  I gotta go get sashiko running locally...
>> 
>> Cough cough, Claude code speaking 
>
>Nope, no claude running here at all, sorry to burst your bubble.  If I
>had, it would have caught this :)
>
>greg k-h
Nooooo lol.

I mean asking Claudy to find bugs in the code submitted before submitting
it.

Saves me a ridiculous amount of time.
--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
