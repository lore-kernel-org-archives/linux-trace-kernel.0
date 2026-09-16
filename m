Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018C0389E1A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 03:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789530320; cv=none; b=opcA4VHKIXLgpd9OmCrbgFBEt+COiJPX4Jp2UlXZGaUQaNkkHR5YsDJegn8pl7/B3qbsdezSC92XpB0wqvX3wbSVnvwgfhEO+2u8aSHV2TU4t7o7biOp/6ndogVtLnpECkk49R7ZUgCs+ecexSBxY8pMWaQH1tc1NjWfbJcr420=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789530320; c=relaxed/simple;
	bh=684D7Flb8NHS/K5FyLvOJG51In7MM0mpezyufLZNn90=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mB+Iy2GZgrMhxK6FsOVIoBj0AErn2+YsqL/c20ibjCNnZU4v9n/wZl+TICQvg3nuNm/bygGQuQijDnc2wO3/4dPAF+9GueJ69V66NysjuviG0QBYQfSjZB4CkY5J34vVl79wKAuHSMIJF1pYcSINw0K6XFBkQMNURRmFZ55h8KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ohEoxmT2; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohEoxmT2"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398beb616f5so136440a91.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Sep 2026 20:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789530318; x=1790135118; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ukRQUFxBTM3YxkUDVCzWjtsHOmDoo6m23BhwxAxqqWs=;
        b=ohEoxmT2BhacRcadblywH5fnmx0gUZr46YdwcXs7QRojAWyzDz3ux+HVGjzqyPTN4U
         g6cgwvB06k6IowNoWHQpgZF3aktD1dwAa8oYyS5lNXp6jkvh+TKeVX2NkLROEv+j9tm6
         aaHYJyKvD3i/jHj4M6M/28SXdzUceRNDYoMa/rBK+vWj9lWeqKCpWc2K5mHCxm64DA73
         5XAKWCPKhzw20rdn7YYOcKw3D2WSBrgYheTktd2isJMymJ2tVG+LCDWrhj6NffHlnEtT
         cOBGSfPBeboMfxhgVBuPY7qSJveTuCGtku584TEbCCkwEhL5/L2rhnM0LricbN2QooYN
         FjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789530318; x=1790135118;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ukRQUFxBTM3YxkUDVCzWjtsHOmDoo6m23BhwxAxqqWs=;
        b=D+ZgIbwm350D+S5PwQ7FeCsGp7U1BpeckVZIPo5JpjpVsnJdl1FUzEYc2lZgUq8kAW
         r5AM7+NeRlG6KnYtLkGKCK4BV+LZFSO4u2yhFxYepgayWJr1hJWFpoRTS/kaIsFFHttV
         VMmAxLS2BHs+diQql9nurnfk0T4SWB/FvVdxtxqrJQmInvW5TfPT3k3Aqu9ZduOrdrbQ
         oIPqN8Hrxp9aosZFFehRWP20ycHv1MTfO69M62XV2QkIMgbh0epR6adzdIgAtqMhdWjK
         JIuSPFjMHp+iEEHah/z6h6kybVm0QRYM9ujun+5ILKo6bQSO/Eu8Mm9W4cK943FzeZw2
         cLKw==
X-Forwarded-Encrypted: i=1; AKwUvBxdOAZ/2vO2TSc8b4if8JTFdZs0cECqreleql/SMOkEFZ5v6ofVAmJ1xUoIlUwUpdCbT+1CkcZBBW3hDnXQcZXuUwg=@vger.kernel.org
X-Gm-Message-State: AFuF++mYAkQSMiQ9UPTGx46iSzSww79JtRXeghaQwyqxU6n1CgQdelRe
	XHlJ5qpSyOmC/vQS/zt6ASAfl6RdvAP4SRtm7nPFyJzRSyaBSxI3KkXZ
X-Gm-Gg: AYBFou1zejKXnQSM0oFUuCOqtH8ZBR5qcUi7UJ+tPiowRXXh7BHNtJ9RKfsuXUIumGl
	0xEH8D/DV7kHhTZtf1kschIWFdF4xZN8DO7TsRHZwv4saEW6h319TXRDtQjujbu6rjU9IY5gqa+
	kvTnrZoEV8JWeVAXorhJEqcmtBWMLZieHRH1umFTnXzVkMr9so+UrrgK+CpWPCeKaAQ9b9zlmr8
	UhgLsgE9gYJYHoaFSuEqT26kJVEMIM1m6f0FfAaqLZA/wpjrvwFz95AFQC2+kPoH4KGLXg3rlBa
	Mgf+89YVhHJJ5+UBM/9JZFhjPkm/S1gPqzb3PGrzFtWerYpL3D8s31DuYwYuBN8qMRyB4A/oQ2s
	OOKWeuMYPGQLeOiGa59cplFrRp/bZd1xMyY6bhRV5yuHv9LFRE8oablH0IUXmYjTKfWNhl27d1U
	nC35BAImTjeDTnWbuv70rFx7rlhHWcOmTktVwpgkw4+cdrCwFscyPk9WjWxsCrPVtbwesrtOnnh
	5fJKWoqUrt835/kyPN8o6F15PNVzQhNGlxWR2oM3pHZmO9ZCP7dB6mmeXGe9X96DJcHDAsM19/Z
	48aAdSAcl4tFyJG7Jv/Pr96SVs0eBq0iGX8og8ySbyjRld8N2KLf2e6NYe8Y6YwOevA=
X-Received: by 2002:a17:90b:2f06:b0:39d:b57e:b47d with SMTP id 98e67ed59e1d1-39e1ff96302mr969180a91.8.1789530318064;
        Tue, 15 Sep 2026 20:45:18 -0700 (PDT)
Received: from localhost (ec2-35-83-186-167.us-west-2.compute.amazonaws.com. [35.83.186.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bba0696sm1902898a91.7.2026.09.15.20.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 20:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Sep 2026 03:45:16 +0000
Message-Id: <DLGFJY2ZSY5M.11K7HK2CLM6I9@gmail.com>
Cc: "Andy Lutomirski" <luto@kernel.org>, "Josh Triplett"
 <josh@joshtriplett.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "Lai Jiangshan"
 <jiangshanlai@gmail.com>, "Zqiang" <qiang.zhang@linux.dev>, "Juergen Gross"
 <jgross@suse.com>, "Luis Chamberlain" <mcgrof@kernel.org>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <linux-kernel@vger.kernel.org>,
 <rcu@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <xen-devel@lists.xenproject.org>, "Andy Lutomirski" <luto@kernel.org>,
 "Josh Triplett" <josh@joshtriplett.org>, "Uladzislau Rezki"
 <urezki@gmail.com>, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Lai Jiangshan" <jiangshanlai@gmail.com>, "Zqiang" <qiang.zhang@linux.dev>,
 "Juergen Gross" <jgross@suse.com>, "Luis Chamberlain" <mcgrof@kernel.org>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, <linux-kernel@vger.kernel.org>,
 <rcu@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH RFC v3 06/13] bpf: Take a Tasks Trace reader in the
 trampoline glue
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Josef Bacik" <josef@toxicpanda.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Frederic Weisbecker" <frederic@kernel.org>, "Neeraj
 Upadhyay" <neeraj.upadhyay@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Boqun Feng" <boqun@kernel.org>, "Thomas Gleixner"
 <tglx@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Jiri Olsa" <jolsa@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 <x86@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>, "Xu
 Kuohai" <xukuohai@huaweicloud.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Frederic Weisbecker" <frederic@kernel.org>, "Neeraj
 Upadhyay" <neeraj.upadhyay@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Boqun Feng" <boqun@kernel.org>, "Thomas Gleixner"
 <tglx@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Jiri Olsa" <jolsa@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 <x86@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>, "Xu
 Kuohai" <xukuohai@huaweicloud.com>
X-Mailer: aerc 0.17.0
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com> <20260915-b4-rcu-tasks-preempt-qs-v3-6-0ad30c4c5ee7@toxicpanda.com>
In-Reply-To: <20260915-b4-rcu-tasks-preempt-qs-v3-6-0ad30c4c5ee7@toxicpanda.com>

On Tue Sep 15, 2026 at 1:17 PM UTC, Josef Bacik wrote:
> +static __always_inline void bpf_tramp_read_lock_trace(void)
> +{
> +	if (IS_ENABLED(CONFIG_TASKS_RCU_TRAMPOLINE_READERS))
> +		rcu_read_lock_trace();
> +}
> +
> +static __always_inline void bpf_tramp_read_unlock_trace(void)
> +{
> +	if (IS_ENABLED(CONFIG_TASKS_RCU_TRAMPOLINE_READERS))
> +		rcu_read_unlock_trace();
> +}
> +
> +static u64 notrace __rcu_trampoline
> +__bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tramp_run_ctx *=
run_ctx)
>  	__acquires(RCU)
>  {
> +	bpf_tramp_read_lock_trace();
>  	rcu_read_lock_dont_migrate();

This is double increment. rcu_read_lock_dont_migrate() includes
rcu_read_lock_trace().

