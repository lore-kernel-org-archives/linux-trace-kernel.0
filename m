Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113313;
	b=Slm6s4tvHAQ6X6N+NbKYPOZxypNYmGIxG8EQ5+hGzzOrcvC/qZN6hEK1SSNAWZAT6KXW
	 Ig3GKftHA8LwtQeaXDC0zNICEFg6lmaXUwedPCNJkXm0KfLAQg/PC1bZbNzW0iGwy24af
	 nen7QQKVtcxlBNrpms/dDgiz5z/zF1EpTXbJNQ55CucTCS2uW+zISDM/7QimjKiQyVTPh
	 UhiCCu68KHH5g82Xirfi0FeuzY0phyCiMNL0vzNkhHOoTYeFpY/cfBLwVE4PdQ5WDOHg3
	 LLssxofkCCn1bU5ar+rzTtFT2+WgsHB0dmjkcJ7pDoQhj8CjFWXpKV6O8T62l6vMWFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 To:Cc:Subject:From:X-Mailer:References:In-Reply-To;
	bh=4JSSeMn7jD3hzJLmiAPL5D8xsSZOgnxpk+LkLJ9f9Go=;
	b=PdCHqmj5C+rnzX0MDkql73ArYjzBKPV48YOJFAP5HQIRQBQRPn1U3Zo+fpPxs38EMROk
	 kTWh0kowyqtSwtXsTL9XmUiHH68fmbX5d+11RhP0W7M5VCYA7HxDSyajQBvPI4E5+SMCC
	 ugTocnMsiIBxBNlMAAB2lyrPpwd0n5mV2j7KOTARvTs2Nf7fEmMdoNXbY+eAw9z0A4GQY
	 LKBuKw27idaHP4tv7Gl3IULRCM2vks23KxYTQdtm/S4QmU2Lshge98SSnbQNbYNyIbWXB
	 wtqKMnQbog3rC1hKVWRYxmgS+GyKjHd12R9GSe/pQVD0UXISebkBgi+Gs0yvA8+aZAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y4RCI7rt;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494A2606BA94
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Oct 2026 15:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 494A2606BA94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y4RCI7rt
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so11949a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Oct 2026 08:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793113313; x=1793718113; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4JSSeMn7jD3hzJLmiAPL5D8xsSZOgnxpk+LkLJ9f9Go=;
        b=Y4RCI7rtBOy5b9y0FhCXLw7TxjLGKoqP7U6NlrFD6q8Ld/t9Vb2wuRj4d5nvLDYNmW
         zMd4eYz+V4fCXjWsiScL3PR0/jOkJbs4iZB/1XrWm7L4dnIYl6zkHE/78s3Hrx1q6Waj
         oRJIZTMGG7SO+raSfVOtWoAkLKKYIlEQb+1KLlQzDppE2+agB1IrvZx0fPK0fPBmKjT9
         tmPkvXERI+kZg+dU9H69n1AXCmu2e6B/KgFFjnm96LtaYjcsqwxw+UdhXxmTEqT0+3z8
         iwxmEvIrStDaVsjlO8tSuKQpCLA7DgHptE2QvFviEIcgFaBknjMXm9B00tSUipyu0hGO
         dOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793113313; x=1793718113;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4JSSeMn7jD3hzJLmiAPL5D8xsSZOgnxpk+LkLJ9f9Go=;
        b=ijPrKG/1bnNC9pwHkIHrNsdmqLsPVOfeyDJn/HIwSV0eC7ubjNX+cssTdCCwda3LQY
         TYUZc6Nk2hASiGG8NE4kpRRADqrqaLrTG7mJdaksPnvQSDbYBTMWH6+IywR1EpBNIlFE
         ARBghFCNzhny9gAbalcX2ku44tCDxvQ65engUhZMhQzxN+5JmXVMWkUUCSASVlraHzOI
         l4m1x4kpISwCo2KV7dm/oHxk62p/yuYblYwhgGXcRDrTIZ9h3AJf1gCbplE8pSSKDI5K
         qaytLcIoa7qo/Y/Ez7AOAb5r4CyURnJCbTViZcM4/nfysU02PvcgYPM3VmbMDMHKdV0v
         9AaA==
X-Forwarded-Encrypted: i=1; AKwUvBxrJyu9+a9Hzk4sPq153tpTK22I8tlrLSdpKtYsphsq2eqGChDT5SMea5r9B/f9PCnwERUAIexe/FRIjeoHKs5Vh0c=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzhZXOxifmB07pmawSc9YGvOJo5Ssen7kf2Cyte37VF2FJSoyC
	A/Gsn8fKT1nN8K0+7klhUj3Ceev3HClfV9GEsveOSMxhjNcsd38FY/pv
X-Gm-Gg: AYBFou371whPvYi/yii2s1P5zGqMLY/uUclDf/GSGO596PGn5Wo/eSXxCrz/vEFeCeD
	vLjR7jKVQQY418qhNPiFxEcEDnRDFWGahCJAXeB3NJ20BPhYvePvMh9agd+P7mibfRN0J2hhrJ9
	jzomjLehXI1PQ5kJItyRxUpleG45VCeY1OBzIBQsi9qBsuUpW7rPCSJYbsvIw0ccWKnBiqusx5u
	Xt+iph2Xs7KJ/h2SD5457IVwL0Qye2QHZEYVfm59JiomqfvXd42v6k33oL35c5NlDRKUoTGllhB
	+qWbT0lVQQidB3zlM6tRZzf6lZA/b8X1GjLSqHqI/uNPD02wPmAFaxNJp8CmcnTfm+pZf5+neTk
	QPbr/zZjFxJDu0XEKkoMyAxdehYkKpBKjJfEUW6YJGLcIynxDPjxpFkHUzBSXNXULgL4DXMohml
	CPzsprQslG6QzME0uAyp81Fmc5NnoCBzs1RwGZdm0zuhvXqiX3NPx+Lx6poMS56SEx/7cGJDh76
	qNO46P5AZkoUwVFA5HM1acPWNC/M1FNZBEJgenbaz0FoCilmtNe91eH1e6Y83GcWaI2DfFpT9tQ
	VQlbzzpq38s/JSfF7YGHz3swk8Q4NOWowIuO4JufWVlyYUaz20iutoJ+lMat8TDi8i82zm7bLJD
	kCqSRhRPS0twdrAwqY8Mig9g0ShcpylrO7D+EotNLw8UU81Jobb8WY1w=
X-Received: by 2002:a05:6a21:71cb:b0:3e0:c102:33d8 with SMTP id adf61e73a8af0-3e7cd5014c5mr6505768637.56.1793113312516;
        Tue, 27 Oct 2026 08:01:52 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8cccd63b6sm2848985a12.29.2026.10.27.08.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 08:01:51 -0700 (PDT)
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
Date: Tue, 27 Oct 2026 15:01:50 +0000
Message-Id: <DMFPMAYUPSDU.2AW3225P0W0ON@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Cai Xinchen"
 <caixinchen1@huawei.com>
Cc: <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
 <dsterba@suse.cz>, "Chuck Lever" <cel@kernel.org>, "Jeff Layton"
 <jlayton@kernel.org>, "Anna Schumaker" <anna@kernel.org>
Subject: Re: [PATCH v3 -next 06/18] LSM: pass struct path and struct file to
 the inode xattr hooks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261027121151.1887650-1-caixinchen1@huawei.com>
 <20261027121151.1887650-7-caixinchen1@huawei.com>
 <sashiko-outbox-186599@kernel.org>
In-Reply-To: <sashiko-outbox-186599@kernel.org>

On Tue Oct 27, 2026 at 1:02 PM UTC, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [Critical] bpf: missing __nullable on file arg in inode xattr LSM hooks=
 allows NULL deref

bot is correct.
Please see commit 94e948b7e684 ("bpf: annotate file argument as __nullable =
in bpf_lsm_mmap_file")
and add to kernel/bpf/bpf_lsm_proto.c when args can be NULL.
That's how verifier knows.
