Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82F8214A7C;
	Wed, 16 Apr 2025 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744825667; cv=none; b=rxGzfc35mJSs0Zqc6gqTpI8z1to0TpQbBeupRA5nNtkOaSYiDpe7tiGeQ6QScQlsv7EvQtmpZOqB97PCbnK8eYPSw5mp3NMDcVIxMWk/AwAor8g8fBfU57fYxnv0kk7RE9GOScH63xT41teGysXDVFE9osckibZGKEzCzH3FYV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744825667; c=relaxed/simple;
	bh=0xMXmPv9am/4yzAmlbNd701D43MOUvuzuBbid2PYMTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpdBodWfORSZ/zlF23YP7DRKMTX9N/ujjkWl/6LAFGWyJM3nM01Ds54L3rop3eEdKwCBIJTtonZX4mGwG0wxNMsnM5LW8z3D4qV4BjPSLDpg71V2NizAERxgKYHQVgF2aW2WxWsyvPf1FmYntBjGPK2xf/aiQ3m7bA2T2Vcf5fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iskdI9Wf; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iskdI9Wf"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3E11540E0200;
	Wed, 16 Apr 2025 17:47:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id F0yZudtRwPqi; Wed, 16 Apr 2025 17:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744825651; bh=k6oIrl/lthiSaffLzih6SQfaq9THlmrqB4n+2W0D0+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iskdI9Wf4NoqrwbLdDcNG3JkNiUVFl9RNIHnGQ5mmkZBYfIhUOMnlOBLHuYxH5rUt
	 oBiZnDiFvczeuE8sz8jXBJDTJ4Tw3hrILTRgBuwoeZwAyk22i+VSu+zEEZDysfmu8e
	 KY60ZSg7M7kilFski7lw//XmoWOidxdv3hajf0hvY9vVf9IKOO65J9XHBEGRmqTYYG
	 QSYMIRDHOIE75VVW0ferdfkvm3CHJIi0FZ+Vn8dswo1NWj/oQwMbw1muJZj01HlfRZ
	 m3nIC6yQm3w8XBwREeuAxB5ibp9INgn+j+TyDNGZNQheMGjRCQmDNHtKBWFCcVkw4/
	 h17sKx8uCCm730W4sLbyr9xErNApIuKrUcA1GsFsZZU9nvJdhtEUJJDS7uLPwIcdKx
	 IzAMB9rfwAs43kB0sAM8g3b4bungROLYQkOtIQ+aq4Xqxb01WVmvWzeArKDAI1+6+F
	 cNXyN5+nFRO1Q1jmB4dqoMZHtX2dipxKEiKVftYNLQsigv1yHfEQ5KEkY1jpbZ6v8/
	 /Xc4h5WcSWaSvgGdj/b67cWpzd/zuTCesGud2UwwIL48ofAdvcGiA22cnSYmcNavMI
	 pgBnQpe6utUyFOMJxvSQVrpd9I6QF1kVsxNWjNmTRH8UB4JNsG3qOVZD/FIXDnyRyB
	 E6WGCuQABS8dWzu58ifjWZ20=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 79D7040E016E;
	Wed, 16 Apr 2025 17:47:19 +0000 (UTC)
Date: Wed, 16 Apr 2025 19:47:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Junxuan Liao <ljx@cs.wisc.edu>, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] x86/tracing: introduce enter/exit tracepoint pairs for
 page faults
Message-ID: <20250416174714.GGZ__tIi3yNzNKoKFE@fat_crate.local>
References: <e7d4cd81-c0a5-446c-95d2-6142d660c15b@cs.wisc.edu>
 <20250414205441.GGZ_12Eew18bGcPTG0@fat_crate.local>
 <20250414182050.213480aa@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250414182050.213480aa@gandalf.local.home>

On Mon, Apr 14, 2025 at 06:20:50PM -0400, Steven Rostedt wrote:
> It's useful for me ;-)

That's why I CCed you.

I suspected you'd have "your mustard to share". :-P

>  # cd /sys/kernel/tracing
>  # echo 's:user_faults u64 delta;' >> dynamic_events
>  # echo 'hist:keys=common_pid:ts0=common_timestamp.usecs' >> events/exceptions/page_fault_user_enter/trigger
>  # echo 'hist:keys=common_pid:delta=common_timestamp.usecs-$ts0:onmatch(exceptions.page_fault_user_enter).trace(user_faults,$delta)' >> events/exceptions/page_fault_user_exit/trigger
> 
>  # cd /work/git/trace-cmd.git
>  # echo 'hist:keys=delta.log2:sort=delta if COMM == "cc1"' > /sys/kernel/tracing/events/synthetic/user_faults/trigger

OMG, this tracing thing has turned into a language almost. I hope you're
documenting those fancy use cases...

>  # make
> [..]
> 
>  # cat /sys/kernel/tracing/events/synthetic/user_faults/hist
> # event histogram
> #
> # trigger info: hist:keys=delta.log2:vals=hitcount:sort=delta.log2:size=2048 if COMM == "cc1" [active]
> #
> 
> { delta: ~ 2^0  } hitcount:          1
> { delta: ~ 2^1  } hitcount:        334
> { delta: ~ 2^2  } hitcount:       4090
> { delta: ~ 2^3  } hitcount:      86037
> { delta: ~ 2^4  } hitcount:     108790
> { delta: ~ 2^5  } hitcount:      27387
> { delta: ~ 2^6  } hitcount:       6015
> { delta: ~ 2^7  } hitcount:        481
> { delta: ~ 2^8  } hitcount:        134
> { delta: ~ 2^9  } hitcount:         74
> { delta: ~ 2^10 } hitcount:         54
> { delta: ~ 2^11 } hitcount:          6
> 
> Totals:
>     Hits: 233403
>     Entries: 12
>     Dropped: 0
> 
> 
> The above shows a histogram in microseconds where the buckets increase in a
> power of two. The biggest bucket is between 2^4 (16) and 2^5 (32) microseconds
> with 108790 hits.
> 
> The longest bucket of 2^11 (2ms) to 2^12 (4ms) had 6 hits.
> 
> And when sframes is supported, it will be able to show the user space stack
> trace of where the longest page faults occur.

Ok, so AFAIU, this gives you how long user page faults take and apparently for
someone this is important info.

Now if only that info were in the commit message along with the usage scenario
so that people can *actually* do what you guys are bragging about...

:-P

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
