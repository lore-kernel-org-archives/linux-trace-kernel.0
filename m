Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F90E37BE71
	for <linux-trace-kernel@vger.kernel.org>; Sun, 19 Apr 2026 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776604458; cv=pass; b=rlrNiph1TDWToOp5Kj0UHp4cQBoh++1HzZnCsEx4AN5ymFEhBUIn41wyCDQMZPNoi76hGDq3+lWoTX3Spwtno8UlbLG7/Gt4bZyC4XN5sgcbl58D0IByrbr0QFNR/01a+vz61bLLrG9Z5oRPjijWiIpJZX7M7J9TS+xsnhvcBGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776604458; c=relaxed/simple;
	bh=qe/8/rd6eZq24hJL9eY4fBiSEHVVKDLumzkH60jo5p0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEbnNLW3XV+buhf7uxXRXkMfEmrtxOmPrD5Zm8M7pzveYAmQJRd/PItEr/ABi6JQdJdWC57uMsTdIKT4LoyqkbcVTPouxxlCkMJFreKHJFcQ6QuCjv6QwKGFOEvp+rFZ+2s1j3bl4mlmy5zve3TQq+7pvAQ9v6oH4vdNTguiPIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=RF+j7+hH; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="RF+j7+hH"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-651bf4a4140so2167329d50.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 19 Apr 2026 06:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776604455; cv=none;
        d=google.com; s=arc-20240605;
        b=g5zK9Ixp5JU37/HWL4L8c/zwARj/qwn0zs9LzIetMYvBF2dgnUog6+i7nSb9qVeXN7
         IEwAkfNYw0Z100IfpT8Ie9lv0WWqNUvykogjq6uNv8wTTJtbzTFU1/fEeIpa+mI+pVrq
         MnISJEUuG3bYHLp41rzD6kWawaxKdmK1SjcrBwUZxnI+tMazMKN9GaK6fKYKKz3A4YFw
         Q85yw0KCI/hkqBBc19mtjqed9T7w7DWr9Zf4wyu/lkSlfk53FYw3FRRIfESn6toy5sfU
         56+DyCGmwlX0JEiMcEZ/k49S8hiQENsPeX5E7rMAe49onf0Tmis15SdXzirSwB1pQu/b
         +ifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X+WVMuAIY6fuTgPsvbyDiChtmsWhcTJteNRfYOEl4tw=;
        fh=8kRJewUH3joUdZut8fG4OdB6MvhtbUyCiILkZS+2NBc=;
        b=cLdMMMqA6qcquFQrlbp2ZcimPEFA0KtAXoxxZmkkufs53NGOXWUVQLY0/zsE1WYj91
         ag22UIU3eA64jqC+Q5a5mOVTsHHDPUfleG5jfe8as2ZQiCDL2Dj5zeBdFmhZGkOHGKaY
         ypKmMUZPhpO69dB9vdJHvQQjeKHIezf7keY8X2Y+HAbaxyR101Rqyta28/SFskWzDzv1
         1l8nVFmbESRM+2ck6yAvY3/N+kaiBJ3sGwoPNBUJvzfF+cpoWUAKaTfFjI7YCUvSdy2u
         TAk0HZNng9Ri0P5qc32RQxxeqmxbBXBTlD4/SlxKSFpIq3CwvOPXuyLnn/Z155JE/BUm
         3WRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1776604455; x=1777209255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+WVMuAIY6fuTgPsvbyDiChtmsWhcTJteNRfYOEl4tw=;
        b=RF+j7+hHVxK6KZm7vPd2VqoOm/wjdXQLWhOzfortaWaPcUVwcAQrCs3L0CFMuiRg7q
         QnfAqyyLg1KJ+FRhOaVPXbDj/1oQAlKqMc8aZVWWLmxNSIvN0DqnMlIAoJn6kuX0b/7J
         7sPHT3tJByJtn837fhiWKur8kP67w4ITGeKuH61ShAM9KSbiPZhuqcwRf0AI+YYvfUzE
         nm7TFbEi+qyg5VUzXDZfGrK2suVGd+PyZxZUbRBAHRptfz+N0eKCGeaG7itaOxMnDo4a
         9pQYTEUA6X1M/ONh/tBNfIzrR7/o898AAKuwOGzc6VJY9VVEJ/2rd2ZdsoDfuP51zO2Z
         aU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776604455; x=1777209255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X+WVMuAIY6fuTgPsvbyDiChtmsWhcTJteNRfYOEl4tw=;
        b=MLr74jjKNROedVss6iqBphQHzqwQbcXVaKsupY1BIfqvH85ww20EIzkWm2iBXK5AF0
         I4ZjSdYnQIfGq56dEVxQuyas25QPRj/MxoIVKnsmdQIzJ9ZpvoCBNMdDwLeN5LtmlOPb
         SAqv6eUNdR0b4tWPjjEkrq/m6P2mbbR7FqD1xXDDzK5EJ09vr1YZQ4NXQruDu0+jCd4q
         yFw4Y/4v20QM2gzunSysi1D2EJsQuNSibY7KJVbSCMzuXCGJ2e0tWse5GwtLeteefO9N
         btL70yCynvfv39/A9S2yhKfr5+Cah4oH5ALYu44I9rJO/1jHx3YKDNrfsNwTp4Lcl1zD
         83/A==
X-Forwarded-Encrypted: i=1; AFNElJ9t4tfrxx9FEk5zrkFKNCM+lCc53k5nsvkFEFdbOPoq22OhV4k/Fq3R7ZYehc4WtcQchSZTO17FxYj7pKhowaj+npc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsl7lGvOuHVJsPocqat3kZqMRA8wglVmzBLW3xA5URWF04nUKM
	/sLt3RlXqUatahxMAXTGxNj5mcFfR037qLrRuZiUzva6Ieap85Hbonoc1vwrMFC/VE70XGfSP3/
	2Kp5oHwtj497y9GLB0/ut2+JN48KS2q7HAbkQFSCqNg==
X-Gm-Gg: AeBDieubiJCX5GDLwDygkPqTky0l/rkP/gRfvUZzlsACeiqwwy53XWRVeMPoGm4+A7z
	zzdOC3kaVq6QP7Nv1dszO5Tx5FK2DEK4uN947hkszIZLWvSBHvHsr+r4x1b1dG+OFvJxXFFayv4
	pIvaDAhh59uQ+zzIR8rhHvA3LMSkPXsdsJUgwWH+V3dnfHnBoHjzqXJkjpOW3/aqxlQ+HUPckv2
	s++V4hVHCXtSY0WQnT5wkQQr1w1IwHwo59iLzb9e998vBaoGnd9yogiZ4Z1Pr7yPM89/di7qMy0
	3JtbK1cSlFCkpFynqme8yxwhXqmR
X-Received: by 2002:a05:690e:4811:b0:651:bcc9:50cd with SMTP id
 956f58d0204a3-653107ccddamr6102177d50.5.1776604455299; Sun, 19 Apr 2026
 06:14:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323160052.17528-1-vineeth@bitbyteword.org> <20260418190456.631df6f3@fedora>
In-Reply-To: <20260418190456.631df6f3@fedora>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Sun, 19 Apr 2026 09:14:04 -0400
X-Gm-Features: AQROBzCejbUFLEO14GEr24qqxXnlBQ97NPzS668jjkdcYvI-3kvv1xuemSCQk44
Message-ID: <CAO7JXPh+__EWsW8fsKi4T+w0jdPxZEfCLQno_ukJk2=d2s0WKA@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] tracepoint: Avoid double static_branch
 evaluation at guarded call sites
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Dmitry Ilvokhin <d@ilvokhin.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	dev@openvswitch.org, Jiri Pirko <jiri@resnulli.us>, Oded Gabbay <ogabbay@kernel.org>, 
	Koby Elbaz <koby.elbaz@intel.com>, dri-devel@lists.freedesktop.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Huang Rui <ray.huang@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Len Brown <lenb@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-pm@vger.kernel.org, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
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
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	SeongJae Park <sj@kernel.org>, linux-mm@kvack.org, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 18, 2026 at 7:05=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 23 Mar 2026 12:00:19 -0400
> "Vineeth Pillai (Google)" <vineeth@bitbyteword.org> wrote:
>
> >   if (trace_foo_enabled() && cond)
> >       trace_call__foo(args);   /* calls __do_trace_foo() directly */
>
> Hi Vineeth,
>
> Could you rebase this series on top of 7.1-rc1 when it comes out?
> Several of these patches were accepted already. Obviously drop those.
> They were the patches that added the feature, and any where the
> maintainer acked the patch.
>
> Now that the feature has been accepted, if you post the patch series
> again after 7.1-rc1 with all the patches that haven't been accepted
> yet, then the maintainers can simply take them directly. As the feature
> is now accepted, there's no dependency on it, and they don't need to go
> through the tracing tree.
>
Sure, will do. Thanks for merging this feature.

Thanks,
Vineeth
