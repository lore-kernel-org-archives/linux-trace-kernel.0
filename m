Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792426133;
	b=mBVL6v3I+vaY3GI78Amr39epQiu1Au6FOIYe51BzlhpUycIFT9hItePMe0TMFoQoDzvN
	 c7d2Qh4PeSDYdzC8oDX6G9emigVdqiWMzo6ZqI7jH0LtPbckl60Q3PIAucE6VfOtFi9Bq
	 +0DQPhLKf3/QX1OddQOjFc56+cx6BIwA8ePAxZakzBXh43LkwnJz5hiNb4DvuzQaQJfbU
	 +oi3u4Qf/7vviuky/UMtHlqLOooeqfwDcsLpCyITZAQfURZi1IjciAW8G7p67D8ERhHh/
	 UsDPoNeXs+8HvgPiDyheTpvx8JtKvIyB7NciABFmN53RFQS7kJ7+HuqTd4J7B6Ovr4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=msDS2Uc5/Enhh4r5B5bWo/aF5i1pI4GZznS9tXeODFc=;
	b=X7S+odpd0x8qJPoHwz3VvSH3mdwRC3sS/hY7rAVo3rWBdQDodoAwAJAsZ8Yh4sWcKvVT
	 c5dEJkrbLwd6Vg+B/Sy8IZURIYv5v76GlDlRDrFWRIdmBXM+3f2AptRlrY+8zc4l6KV1u
	 imJukEtUIRd+7Dt/RMTo0FSnzHD3MsewhMOazEQ8E3kJOLuahs+lGpZtpz49b23W33lmf
	 jY+vfpd5g1xrRBwZIiPxRIGPMtajh/7jNInc8uEuCMclgU+CbQtFAHACwIwEgZup1EjhC
	 bJjJmw4+bouBjveWOnzf3JwdGQ8CqddyrLSz2W+vszwoA/ebB7hGkFz2Erbih7vc+Cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m12T2hZV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455B3606A33B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 16:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 455B3606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m12T2hZV
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-398b3c37877so1326134a91.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 09:08:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792426133; cv=none;
        d=google.com; s=arc-20260327;
        b=PhcFGxAQVYug1wJqZLjCYdjleeYoyfE9rjJWj4egijJu322oZvwggMI8oGgtLXJOUm
         HNdjxfq6AMJ0DLHwjGK2eJmfOo6arcpUor8cjbM35POF8vDjLsjb7qS8TVYPwE1UHe0z
         vhV1htcE2KpHzxbqwseG0697RSiuvrClFhSpRiHMojCesEpY5P9KS/iQd3EpaguX4koo
         pY3NTndk92RDKTAlBKCG607GwsM6JLLx27LVTuruGKmg9hoaYI885Gsf47RFtDqUNGKk
         jsTOqQzw++YsvAQfC06qO5VFEUmvir0X1jSXct7Ve3cLf5owVEXiEIa6bRQGI6GHiZ19
         wx7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=msDS2Uc5/Enhh4r5B5bWo/aF5i1pI4GZznS9tXeODFc=;
        fh=HRSRe/VsWfPN62QVfIPLVL97NICnvw1BXCQvkAY/CnA=;
        b=RrtyeCXyKlWPXTODQBk6wsz6DhkJk5PIx75UpVGOlYM5o/SCtEkhW6smre3N5BFgiz
         RAhbuVu0/gR7YmVwK5CTGGYHPuURU4r028uKoOQ5juXhRqiL7KasPLaS7HMnl0f951a6
         TdT3GZks9iUKtrF+1HkwlEnHeUq2C8kNkbGD6kiGkiwqm46k1nuH3H/FOW+RVEH5EYFQ
         xDD/Pr2yx0uGCfetWA6zgk2REo9H6Byw1vUJPNYKTFV0OCPiQSAgzwnupM2VwWA8OLC6
         5KnHMbTmkRynFPtgx3AS1SQWHbfXgVhxvA96Bz7RxE+NLEeuJWL3s2mq8vTsGmQ+mpNn
         OjqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792426133; x=1793030933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=msDS2Uc5/Enhh4r5B5bWo/aF5i1pI4GZznS9tXeODFc=;
        b=m12T2hZVaWUMbmCqdm9gVfugj/lXfdK+nmnfQA22fKj2jBfRrHywGX36XLxQA+ZbnQ
         Boj2/YgXC5SnV2N0DnStQ3awnauG5JLVr+Jc7ZzQ6NyuBV5XS9AoV8E7/ogNOv8CXMPD
         KrFFcxoZN1YvxhSfAXbZJdZSK4axGx5A/60laZgZZC+Z4gifvMOl2RYRD4uDXQC6LZva
         xQbDR3EaGDoSr7hWq6u/ei1M82R+fT2bNodj7CQtpOS335QnFEyDjH40JDgHgjihW7FI
         fT3RD5huikbzB+KqacRvyQksW/E2xge0qZ36TN7LcBtntIjCGttV9WPRE2KCxFto6snl
         RUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792426133; x=1793030933;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=msDS2Uc5/Enhh4r5B5bWo/aF5i1pI4GZznS9tXeODFc=;
        b=MqTPa94qu8HLGOb6Ti11oQexEqpyvfksTLqdsF4P0t9SR5K5CfCe6SFHRuIOu5Q7Qk
         ycBAz7vq/Jc3WPKExKoH0370IylFBDdyb32iqeYDTnEpwQvcKFiyQBZTyL/a4PS6BL72
         9Cbp5PMGodQ+uxOtYts2ZlVk/upADxacLvSu/XIN6m8kqqcbZ5LHf2xZAJLlfgIi3RIb
         6n5zKegY/J/69wo7clmv1G17abnJUYtSS8DmaV06VNLsrqdggYhDEEA7o6hlZi9xXAkv
         +f3WyfR6kU5MiexK3Ds9hbwBl+gm0aWmcjRWP2H1jxtD55j/GFkXs3j0miO1r34+o6XM
         2fNg==
X-Forwarded-Encrypted: i=1; AKwUvBybJd1civrabCMCaHzMsJtTYBQwVubIYpgBwQ2RuqDe7rZm7t9DFmJJKzc2KiHsIzkPLoy7ZBoROYRo/olPGgacvoA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKC8P0ebwKLzuECETaPEL372jXdOu2Ksud6IPF9bcn+NyutQi1i
	5AWSm2DxAglvF2MbM36ctDoyLNzMiqEVUz7yfDMalG5vngrlyLpbZwd/fOhb5GolBtvizdGWG3+
	yGviXfbmOw4qX1lBb+SwOL0ALDOuMGkk=
X-Gm-Gg: AYBFou3agUtSiKdI43XmEnLLoui5rtBhLKuSmcepkro55GOveXDmUuKoDl6GL7C9Mzf
	04lgLPaKtHjfDpILHer4Hr58FroJkXzQ29ezbrmNxpSQtgTVcK+2RpcxKYahdgM7+4E/vIxJOaZ
	RWAo/6HlKUQ4uJC1n3HLLWvORE6heWW4VRZ5oyH4K4tb59Vywq9mci+8FwrcgzIXMZnZGrbMu6j
	luPsHoqKdnG9x7LnlVIfPU/5W4/AuYV6OMf4UMelSBFRxtrbgF/iqqrEkLUbGGLVkpEdOqZ4nPv
	gX7dbTW4I8wj8bh9+c5hM87YnnYQn1J0iThaTg86R49WBRuHFr0R9IVr4lS83udulrfxiORP2SI
	zKL0QUzBZzKbP0ZVLWVWJpAFxfPE3gvJxzxtyjEY3NEM5ERGNR/2iPrboyJsN1ljGEE4P0PUjDG
	12xAOHP82bn2zVvS43GZNqq3Xy8zSK2ipwvw==
X-Received: by 2002:a17:90b:3c05:b0:3a0:e4ce:31fd with SMTP id
 98e67ed59e1d1-3aceefc4ef4mr6323225a91.10.1792426132592; Mon, 19 Oct 2026
 09:08:52 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019080709.477548-1-18983559317@163.com> <atX2FsqHIkOvhrLy@redhat.com>
In-Reply-To: <atX2FsqHIkOvhrLy@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 19 Oct 2026 09:08:39 -0700
X-Gm-Features: AclHuK_1vW8c3v9yVgPeu8TsfazzwGD9-e2JI_KbLz2M4NCvt5GeP6hDT09wjMk
Message-ID: <CAEf4BzbX7vmpd2da4eKphX1r8=QXGey_1m32-KP=-8FOkFk15Q@mail.gmail.com>
Subject: Re: [PATCH v1] uprobe: Assign session ID before publishing consumer
To: Oleg Nesterov <oleg@redhat.com>
Cc: Binbin Deng <18983559317@163.com>, mhiramat@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, andrii@kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 3:51=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 10/19, Binbin Deng wrote:
> >
> > consumer_add() publishes a consumer on uprobe->consumers
> > before assigning its session ID.  handler_chain() traverses the consume=
r
> > list under the trace RCU read-side critical section and can therefore
> > observe the new consumer while uc->id still contains its initial value.
> >
> > The race is reachable when an uprobe at the same inode:offset is alread=
y
> > active and a task hits its entry breakpoint while another CPU registers=
 a
> > second session consumer.  handler_chain() may store the stale ID in the
> > return_instance consumer array.  By the time the function returns,
> > uc->id has been assigned a nonzero value, so return_consumer_find() fai=
ls
> > to match the saved ID and the session ret_handler is incorrectly skippe=
d.
>
> I guess we don't really care, this doesn't differ from the case when
> consumer_add() is called right after list_for_each_entry_rcu() in
> handler_chain().

that uc->id is important for "uprobe session" semantics, which seems a
bit different situation compared to barely missing consumer_add() in
handler_chain(), but regardless, the fix looks good, we should apply
it

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
> But the patch looks "obviously good" to me anyway, so
>
> > @@ -1032,8 +1032,8 @@ static void consumer_add(struct uprobe *uprobe, s=
truct uprobe_consumer *uc)
> >       static atomic64_t id;
> >
> >       down_write(&uprobe->consumer_rwsem);
> > -     list_add_rcu(&uc->cons_node, &uprobe->consumers);
> >       uc->id =3D (__u64) atomic64_inc_return(&id);
> > +     list_add_rcu(&uc->cons_node, &uprobe->consumers);
> >       up_write(&uprobe->consumer_rwsem);
> >  }
>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
>
