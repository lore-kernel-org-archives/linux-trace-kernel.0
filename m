Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795663797;
	b=bR3q3EnQTg5PV7FDRIhkCUa99ys05MggLNt03G3vrDlVu522Nw/z9ZDk457ZuOEDwPJI
	 h9iq7eiC+oGsO46z+kWpl+YuWhlB/tJXqHqOqO98hkKlcASek6qaoQUR7tlR39DHnVCBz
	 14+K9fFSDbnUpPXUEVjkbU1XbY0Q8mZhm3wAfnr7BS5XRz5Ajw4Yx7M7xVzbh6l+lFLHk
	 eAlBJBLprYEoHGP7uGpcTpguM36rBDs/7hIFpEIbSAm99U7jXc23s6SvgKYyPyxIGW0qB
	 Q0A+I93XVHTKh5UI2ah5ELK8FV0NOKe/y/p+HQCEckyb7OL1msIlfhv95Y61aeJONaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795663797;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=IpBPoqnT7XRaUUtao4GwnTNrNP2Jb9pC0p7vG2cG0EM=;
	b=l/0WQwdn+qVMR2wvWCMwgHcpa4RULNreodRZnZXLNluid+7KcX+kAZh9B+n3uWL9tz1P
	 t8uepLP9oRQuCojAOQ2Od7sLjnJheIWaG/jiQDeyD1EQlanuQdZevzczldVkqijEmxD+R
	 pXbKvxL/dFMVbuVRooAYETUwV/ViSzFi8KNjZ+QK+9wD87w7etLKTlicAw7dUCuZxnjmz
	 oKfki5pJ9tpWddPY7Bf5tiBW5hYG6iMKeRnRP93YjmeyRQx1KpUOrtKC6NxMUYZ3c+ZOu
	 rVTWU7dTxoyxaDNp/wYfLbt4l1GYh1r68nzeDG08yWgD4w4UyY73JVXUIT1QSAXn2vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ge74aeZ9;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2365B606A31E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 03:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2365B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ge74aeZ9
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b413997581so5064379a91.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 19:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795663796; x=1796268596; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IpBPoqnT7XRaUUtao4GwnTNrNP2Jb9pC0p7vG2cG0EM=;
        b=Ge74aeZ9dydOcRkiioTsqEpJtsFEIaP6vYCZeCjABFSs7FcbSagrDKjdNDqExJ2OHc
         lMlLqUIv0U6OJHLrfjihR7nT2vs1FRTjZjYNJK7cwbsmjp3WyTU5M/P1hfAwjqbb/1Bf
         uAKeS+uvL/l+4lOvI4wqObv935uvCp8kcqszPQQvA/m3bGbb4e109JkdYuIr4oOHdb3y
         y67zBtmUukRrJ64tGN6gG93dMJvuE7KnrGAgl4yzXfXGKgPRCVLffLCNkDP1yahMniA8
         41HMs4QhGiHaW2V9kzfQekghes5I7HYCD8pHKPRNQusAh0c7QmzvFP3Vgtx0HKo3nJAs
         DMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795663796; x=1796268596;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IpBPoqnT7XRaUUtao4GwnTNrNP2Jb9pC0p7vG2cG0EM=;
        b=Q5HBdjuC3XAqjFMx6gLuZBxVP/PbBx179Sp93OtusEac+7Qn6paaW0vC+/xg2XuH3X
         xhDk2/3CFDqrDPbrv/6+ytYesb8KvIEQU5YiovHRUz5TVVV7BFT6QyATWo5MzXGy6TSC
         1IDNVDtnBH3SnuWP56xHUN0V9HylY1YI1RIUKwidXYWEQ2bZ8NpB65J00eDQQ3U6qYJv
         ZmDRYijZtQRHXSnIfYz8tEs+dz/Dbh2LZ+AvnVnEz+FdZTRq81ePnr7PwNfw4ed4yvsV
         VwOK8zEIwPbwGH3tHSfbmcHJ+BkVF3uFymKJkfs0Crll5JI64ODBRn+x7PRaBFMXIBkf
         Fwqw==
X-Forwarded-Encrypted: i=1; AL+hErGVXwNVL+FSb0kez4jm6mSi1EzfY1JG8W9oFstSh3RxZDvlT9tycidsvktR/4i3U57PLRJq6NzvguFxa8VDuSiOLiM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+rfdOy+asOkOo7rto2UonVM7PlhOZ9FV0FbZ5h4I3M1z/e1gOM
	roaWYi3pyzbTj7PaW/DTrMsaSlBoEn9Ux5Mrq0eacUIL+L6Gkknnb2YY
X-Gm-Gg: AZFdTZeKvyuiZmhE1OI1tC57EaCdDBN5izkDFu39v4Rklj2iyDxi5boNgBcjpU7VtZn
	qcD5h60jNSiduF/cBnlcHeHsjg/4pa4HTz73A153QsVN2Ew7fpnjPvkOP0KKBzDaJlGopSpMkok
	K5FgAej7YjvoOQyDMuwr6NVORmrCP1kO+79f4L5t18n9zRsqxlWR7ZxV4XYVEEu3519SWS5wMf8
	tGafDsUljfD6ZJ135lJ4HXfRrIo9wY2vlii8FjwKz0mRUU3FnvWuSViWt7y9gwVmHbJry+arcco
	DQxuPxdXIxqrdgIO1YWru5ujvuceDXWJpyL/SizAA6AKAkv8nQJ7AiYbdiwYcsrdF21pDrUQHwL
	u7ihkpQr7uN9EDFIsNwc6hrENRq0sCU1En5ac5SIMHmSzunXHc4YzQyYlYNJ9PJGrUSDtCGWAc9
	UDaiZm136K+eKCuDN27mCqUnT+t6XenPHnLJdykfIWltifklInmhC7PSQErY1N71Z2OfxZX031r
	zDM4uTvTrptYnnx6qYXdPqKdaD62JU/JwZyfm4PD2Y9D6vPp4dQk0Uzo/Vaezq4OERl4Y9I0syd
	ZtV2F9Z+WfW4gqHG1FYC34SsHQQV/yJyzwQEh/J8U0+qfBDK+rmHB8TvtRRWC1w0NjYv7bxH2UH
	cRko2/LCRY3vxfwpqLJSP3m90htfEHEmVWw==
X-Received: by 2002:a17:90b:35c2:b0:3a8:c0cd:57f3 with SMTP id 98e67ed59e1d1-3b41c8e0c7emr16856091a91.18.1795663796337;
        Wed, 25 Nov 2026 19:29:56 -0800 (PST)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40578d771sm32691589a91.1.2026.11.25.19.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 19:29:55 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 03:29:55 +0000
Message-Id: <DN4TOVIA1HK7.HEPNDE8WF6HZ@gmail.com>
Cc: <mikeba@sentinelone.com>, <bpf@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "JP Kobryn"
 <jp.kobryn@linux.dev>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Check recursion per task for
 preemptible programs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
 <DN38312WXPDJ.2KLUTCWSDFL3P@gmail.com>
 <CAEf4BzavErcSOZhGobqEo68d+2bCnJ8vFxxT_vqb+oQw1j1d7g@mail.gmail.com>
 <DN3X5OIRXSWR.2Y70DWFMPDXQF@gmail.com>
 <CAEf4BzYxBM3R1s6XDSpN5htzMho4Jp2uBsx9ZBKTPNBvmEffxw@mail.gmail.com>
In-Reply-To: <CAEf4BzYxBM3R1s6XDSpN5htzMho4Jp2uBsx9ZBKTPNBvmEffxw@mail.gmail.com>

On Wed Nov 25, 2026 at 5:35 AM UTC, Andrii Nakryiko wrote:
> On Tue, Nov 24, 2026 at 6:00=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Tue, Nov 24, 2026 at 01:47 PM Andrii Nakryiko <andrii.nakryiko@gmail.=
com> wrote:
>> >> +       for (ctx =3D old_ctx; ctx; ctx =3D ctx->saved_run_ctx) {
>> >
>> > do you mind checking if unlikely() around ctx improves performance?
>>
>> Mike,
>> pls try it on respin.
>>
>> > So basically to opt out from this behavior BPF program would need to
>> > stop using any per-CPU maps and just implement its own poor man's
>> > per-CPU storage?
>>
>> poor mans's per-cpu with bpf_get_smp_processor_id() shouldn't work
>> as an opt-out. See section 6.
>
> it's hard to weed through that verbiage in section 6, are you
> proposing to mark "needs per-cpu protection" if BPF program is calling
> bpf_get_smp_processor_id()?

yes, because it fixes real prog (falco).

>>
>> > And even using SEC(".percpu") would still be detected
>> > as per-CPU usage, right?
>>
>> This one is pretty much brand new, so there is no data to make
>> a decision. I can see arguments both ways.
>
> .percpu is backed by PERCPU_ARRAY, so we don't need any data to say
> that it will trigger the protection, do we?

I think it's slightly different vs normal percpu-array.
.percpu is pseudo_map_value
map is pseudo_map_fd.
So we can distinguish if we want to.
What I was trying to say is that .percpu is likely only in Leon's tool.
So this one is easy to fix is we do _not_ want 'needs_percpu_prot' on it.
I'm fine whichever way.

> Still, choosing between handling all events and having bugs (fixable)
> of handling per-CPU data in my BPF program, I'll choose the former.

but with the diff I proposed you get both:
per-cpu maps work and there are no missed events.

> Even if we don't want to make that a default, that's fine, but please
> at least give me a way to opt out from the kernel's
> over-protectiveness :) and not using per-cpu maps is not a way to opt

I don't follow what opt-out you're asking about.
Out of implicit preempt disable when you're using per-cpu array?
Why? How does it hurt your prog?

> out, it has its valid uses even with preemption. Think about simple
> per-CPU stats/counters updated with atomic operations and aggregated

wait what? per-cpu _with_ atomic? who does that?
bpf gained _local_ atomic just weeks ago.
per-cpu with full strong atomic is odd. Why would anyone use that?
The only case I can think of is nmi-safe-counters.
When we introduced per-cpu maps 10+ years ago the use case was
packet bytes and count, so that bpf prog can do
map_val->pkt_cnt++; map_val->pkt_bytes++;
and that's what everyone was doing since then.
combination of migrate_disable and preempt=3Dlazy broke that accounting
pattern, so implicit preempt_disable unbreaks them.

