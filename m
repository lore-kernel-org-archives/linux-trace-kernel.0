Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD4C382281
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410570; cv=pass; b=MVP2/NF3MbbmKLt5126kWce7dYLAsjJmVRd/MjJhAlLlKUy++lR6FdQC5XDcvO3UkOjtuJluMpVd5/DCqJ2XmIVSWpKsU5Ypv1R3cs3xv4GrVm8z7+JFc7gA0oTSw4CQLiSmvRkgOnf5EDhGkEwjklsreLP0fxJuUEC8075X81k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410570; c=relaxed/simple;
	bh=a7/dI9iHAkAoxpT/Y/jlrZ1Uk/u+tnKK+1+hPiLUJTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5/f505KKqtDfjNEO68YWKcHs3STDnB6UojJYaE2IupQhZxnQkCpmDGnGPfnyQmknrEUduWCBTqCx2tEwtJBgw1dc10ye2vkHRM2q1cBwmxuEIihOM7nhsS2LPhAarHOxq43guaYr2dJlekVphqQOeDZEGCt8EFIy56BBTRWJuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=ObfNwz7s; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="ObfNwz7s"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64d5a7926cfso2323771d50.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 07:02:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773410565; cv=none;
        d=google.com; s=arc-20240605;
        b=bfxIQk0TQNS2riLAyOQt1bAod0zk/n2ciBhYO8W3szIC85w+J/jBeYFfy66rFcXdQt
         Ym+KKsVENr5qdzzpF5Qqgp0SKfJw63uti6EO1G6bP8BUjmcobTNotgLtV4C+kCUeSMzM
         9SjD05+xxtwZ/97TimcdfJBDpmELphrDSctUbDoCqFulcVniWQvFbhIgMA0wAe8SePFo
         /XkhAANRhbba2HpV93MTjXwij9pvTq6Jie39CW3QrqNr/ktu8E/B8K9225Vn/FY8k+P3
         9hLkynA9HhUsI+Lv5O5z1ZpqGGIde0RIserBlhfZDJGTiH7q20PSH80bJMWNlv9Z7/Qf
         Axtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a7/dI9iHAkAoxpT/Y/jlrZ1Uk/u+tnKK+1+hPiLUJTk=;
        fh=GLMbmm8f8IWp+hLF+oi+QRG5MhDzC+IdTHYJI/TP9mc=;
        b=aEfvFshYEOWnsSf+htJXzeKUZMz8cUiisezpreobSnFnnDFtg/oFmWsUV09PPPzq32
         e7RjjsqJYpEidQHEfSEMD+FTQ5xu062pDvP1DlYGEjMk35+DKSh7tOQ3XPMcNsF6MZ4G
         gzaC5L5DuOTo/51aq10S28rh9PviQlyBWKTnp6yT8mwUwiU6oYnTZI1VH4Qm3OsZkCU1
         BGkG07cJmUKiIhe5ZGzpFhRO0Sstb8Dss0HWxsMr6bY5tFIEwOqnOMwweM91ityrrNJX
         QUrJ21yzH4hIn4kT46kbiOGqBrfxQshcPo9sg/1gpeaBCHY6qQCvWnreMBKAHmKyZphn
         JyGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773410565; x=1774015365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7/dI9iHAkAoxpT/Y/jlrZ1Uk/u+tnKK+1+hPiLUJTk=;
        b=ObfNwz7sVmzZBuIGYYUHNiLCrYOnrj8c6jSXCTXbQttafWQ6iigv2iFCUWBaoiYoUP
         65QJafHt+sCKkuHWwkmPoCcyygdqmYnJqwQvkPOoFp//2xTrPOAnMOEt6QHOb6B2JvqT
         uUidn8yG11+xxULj+cUGv2RAFi7xkRZfAAMzfTE8wLSqLl+bB0W1/CQna7kgFTcQ079U
         jdJDbGknVFFIGRjt+9Ia/rAPUbdCEaVBzQY/lQOSzveUUMV9JbrJZ9dM14sssdL0Veoz
         2HvOhbyl3fwXxpTdX3XOVWdJQawUfi41VBhM025fBbFm4jHJUnRUxEJqrBTBuYU1u6Rq
         p7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773410565; x=1774015365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a7/dI9iHAkAoxpT/Y/jlrZ1Uk/u+tnKK+1+hPiLUJTk=;
        b=L2kTdA123MhvMOufXcDJ5UMB4TgSE6PUFXxJAqp/TrMPCkWICg74EkFxuVfrQByViE
         IlwjpFycymvE1Wr5hNy1obIlc4vBNlXa9Aj354kKJcdfwgXoEybVdvstql3W0AAf2JSv
         1YWSviQ5+EBi1Hj+80rJBanVm8Po6sKGXej9Zs7Aavy/LV+OEadmdaI6Q05bmiDv9c4O
         FbElterdboIgMK5/JXF7OlIJq4tqgRY1NpiKFZj8CAkmCwgbD0CLoEmxx8MgKtaEIY8/
         dxzjKQ9VyJer+BkNvT79yacCy9KWSRqoLRyYB2HvTtE57nv2fMhebLSP0QK9TMCbpOVb
         /EiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2C0n4Ht7prb3ZeMTYdbTLfMjY4QAHayl605SQkXL+D4+ypQtZWi1sd0y8oBA72jYuFpfpK+jD4imBfnlW6GpaRVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgLw9IDwqO6ZmkHfxVXw9c9tCR1Ac+bBEbQ0iMpY1iyOheUYrD
	cGvpII40V9G8rbew2+VpOzXOkF6jOOuRK5+RLgMZzIjXUzXd3+di9lc85Rt6R8BJgZTqubJB0Lx
	G7lsX9YGov1s7/nYdwY8r1+B0GS2hLm8QbVCFII/Bgg==
X-Gm-Gg: ATEYQzyU+vzeAKmtYYdyj+GyuVYW9Jp7l1qKfoZ8GneFRnGqeTwzGbKBzSSF2iFJKhr
	L4Tq/XL+YbAFiOV30pMuUK7YRMKI4HjPakNSLZmnKU7AxwwE7ZBArSaRHj+Xj4AjGGHsuQd40SV
	UHCKYyLBRw2uvkz6WMVBJmlifwPUXvETmvzRp+9JhBSPOWKMIYbukBpC6H+X4SYI0hD+tPIE/Lz
	lThRGNA0qesZhgB1RAqtPgQmANlOZhvR52qBGs6/yS92zcbfrnr6KIVI2iTZFS6gp0Bzy43n0oM
	gjw+uIA=
X-Received: by 2002:a53:eccf:0:b0:64d:568b:bcb3 with SMTP id
 956f58d0204a3-64e62eeb40fmr2691449d50.9.1773410564388; Fri, 13 Mar 2026
 07:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <1e3c2830-765e-4271-89f7-0b6784b37597@efficios.com> <20260312112354.3dd99e36@gandalf.local.home>
 <219d015d-076b-4c80-8f63-88569115fdad@efficios.com> <20260312114041.5193c729@gandalf.local.home>
 <1becdbce-2c01-468a-bbab-42b5dea9fdf8@efficios.com> <CAO7JXPjnnruhM5oC6xMgnYaQ9efzYFqMCFiJLNM3HCQ+ZeCiJw@mail.gmail.com>
 <CAEf4BzbnfyhCqp0ne=2gRnVxp-mdGmuZwDeFRyhRYH+eDcz2-w@mail.gmail.com> <20260312130255.6476e560@gandalf.local.home>
In-Reply-To: <20260312130255.6476e560@gandalf.local.home>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Fri, 13 Mar 2026 10:02:32 -0400
X-Gm-Features: AaiRm51K5Hc3O7_rOVK2jMiMzft9bvuP5pyZ-VF_j7db91GKvyylhuGDp34sRoA
Message-ID: <CAO7JXPgHYZ9zF1HFahb2447X85YRZCQQBHB6ihOwKSDtiZi8kQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] tracepoint: Avoid double static_branch evaluation
 at guarded call sites
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Dmitry Ilvokhin <d@ilvokhin.com>, Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	dev@openvswitch.org, Oded Gabbay <ogabbay@kernel.org>, Koby Elbaz <koby.elbaz@intel.com>, 
	dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Len Brown <lenb@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, linaro-mm-sig@lists.linaro.org, 
	Eddie James <eajames@linux.ibm.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, linux-fsi@lists.ozlabs.org, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Deucher <alexander.deucher@amd.com>, Danilo Krummrich <dakr@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	amd-gfx@lists.freedesktop.org, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 1:03=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 12 Mar 2026 09:54:29 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > > > emit_trace_foo()
> > > > __trace_foo()
> >
> > this seems like the best approach, IMO. double-underscored variants
> > are usually used for some specialized/internal version of a function
> > when we know that some conditions are correct (e.g., lock is already
> > taken, or something like that). Which fits here: trace_xxx() will
> > check if tracepoint is enabled, while __trace_xxx() will not check and
> > just invoke the tracepoint? It's short, it's distinct, and it says "I
> > know what I am doing".
>
> Honestly, I consider double underscore as internal only and not something
> anyone but the subsystem maintainers use.
>
> This, is a normal function where it's just saying: If you have it already
> enabled, then you can use this. Thus, I don't think it qualifies as a "yo=
u
> know what you are doing".
>
> Perhaps: call_trace_foo() ?
>
call_trace_foo has one collision with the tracepoint
sched_update_nr_running and a function
call_trace_sched_update_nr_running. I had considered this and later
moved to trace_invoke_foo() because of the collision. But I can rename
call_trace_sched_update_nr_running to something else if call_trace_foo
is the general consensus.

Thanks,
Vineeth
