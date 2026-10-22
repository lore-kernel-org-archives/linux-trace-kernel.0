Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635743;
	b=YDk3IGs2xLn6SDisgDRm2dEVAZqlCvylIcK6NtoYemv+p0wV2YVxqd3ceh559H/Djmw6
	 tQO2wAeRHgRuU41kzbrTw54ShIXLWJDrGED9+x4ozpVzm09FaGR2ZHRiGzyTPHjsjTOC8
	 Or3I5EZ/ySlT/OFEUrndlaMSVAlMH9mhlhdrBfrbtLVXHKkq6BZfcYMyASndYeg2JJoyU
	 x99n3TPtarGXPbTgVdWg3lHnrCqMJd5DdUQ6edKy1f8iflpDEZdbM3ksWyBZzV/zfSYvh
	 oKivt4wT414cC4XP1OP1fenBBY1Vmtg8uHJrwZ9tKnR5OveXhmd8CEIEJ5ReKD6qjJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=XxjX1g1mQUEUPhKLrpLxYSgZ8S+x7GSgwLX7BwyjX7g=;
	b=de+DbEBolCXlk0TnJuRIv/PA4wzEkWpd6LMv+sgA0IoaRowqMHXyp9QGq/FpDbLmZNXC
	 kZAWZojvNKDFErfNGZyFiR2BHTazncaiA3CgZWvhkDA7M7FGNVQ/fpZnxY/at0c34PiKx
	 AOsvJmYYtAelur3NhYEMQkza6RhatPLbzaVC9VKy1QTuERrNPO0fqb2lJ5rbvWpcp4ty0
	 2IOWZQ3vapxo71eiu+l+oFrVovMf5d2FButDQVb2E0OD6Clbao7R0Knb+h7olphrvY28b
	 d5N37TwgBxKUBoKq7IKsMhAsOUD2DOVN6UU2aCdAsMy6oNLhKQQBfLVFxixolzDW9sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sS0MesHX;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A62606A31B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 02:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01A62606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sS0MesHX
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a06b436dffso569155b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 19:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792635742; x=1793240542; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XxjX1g1mQUEUPhKLrpLxYSgZ8S+x7GSgwLX7BwyjX7g=;
        b=sS0MesHX2nvWA2URY0k8Cne+sfJOI5PDPY0/f9zuTS95LHs/n/U9E8Pa4fzDUDcan+
         Y9rcsec7bezD6Guv7ewLXhN25+qbv8/QYe+Nt37G/XwT4gtFsAw4dBx/scmdeSeprx8F
         yyYmOQOxj61oR9X1k4gckGNgfuwxjCdGgyxCQFj1M4GVJ4knVIsYp4O+Vpxpl2Ncu06y
         c78So+Vegffz8XffqmKkG/C++ukW6P3hjj0QtBPdRBMEZ3yxU/7oayY14RY5Y/KYxQ1q
         zYqw5lr40dCQEe9v04A1K2soetRjLIKPH5jCosRLRnOIYPu5etD6U75ESDrikvZjJQvJ
         nS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792635742; x=1793240542;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XxjX1g1mQUEUPhKLrpLxYSgZ8S+x7GSgwLX7BwyjX7g=;
        b=DcDPTQgs2yVbj+yMEieFH4fEEgcZpGyRSlAAR7txePFuNTYpcEtcHXtiShIMk6oLaa
         MFZEQifl2c42MDSsBqZMneIPS8wiO4B7K+lleaBJXQent9vnrrada5fGrIZyWN30inpV
         A7cJ/NnL3m/KfGonEY4eFpO4Nt5rVaf17zQAkmnHHn9giNYx54FTM+s0O19U1jK+8IDW
         IfbyroXYk2iqva3t2VUfwypvqXKIS9J+nKmNAyGRh+fzA+N8VUPAPdExybgU07AcTXdU
         9yF221ysY2DeY09zO7185uTNZVceFqdOHVcz6ORLVwLkg/5UimdQMlEDQt9H3CuHuzLH
         m14g==
X-Forwarded-Encrypted: i=1; AKwUvBx40ZkcaI6BVUlnfRzceBK7O5rW+HueN3NBcL5AlB9ua+2zlDBwoUjdoqHVs5IZrwwfdWenNutzORweotZseIoJHUs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKuh/JDbsj9uqeog5nChWgm9KlG6P784vI0eTz3bo5jztpzW5GI
	syunNRQSF/AqXJXYUEi/dwA1WlkLzzFv/7iDtrXpqwWnvZoOczMLy1xV
X-Gm-Gg: AYBFou087tThxxKZAEoo6gG39YG1KlO44ZhoskRv6YkmFn1Jm4zaN+nWIYCHE6KajsD
	noIBCq4j9SNVnjXxwC+XvylF+72BvjpF3YJ9KbyXHOzfvTb7CknWSdEVrgrRsvIxb5Jmz3ajuF7
	yvFBalbVvkvG7p6TQuI+9ZU1rJAf9ZmCEUvz4J9Asm929YDl22F71om637BmlCRvkRE5jh1gfFx
	QTe03D/elXnGKxXjMWRG79XLTKcwu6FDeF4yDRgqKHTaeR7tPFR4j+/4ajcLXsAuXX8mkR2gFim
	fW17A0qgnHC2UTM/S3SaI/pDj8Im+bPj1x9ITEsR/xxWt1kfDN92Jfv40XjOL5avWVTj+4zHRkK
	RsSs2S+8+4SdrOjpbR98NcYMLHcKGuSSqLA2XoJQ9c4b6DyitujU0/scSvKs+yhJ0iRJnEtucT1
	7+ydehFc94vgc3O8rH6HJyg3akWd002dHwl2ZqkxnMu942oCmZ34KBPuAdpHNo+VjhksVliuG06
	acG3JsYwrIu0PZWcrQWK7OblbdZPrNFKnxh3qNApULsbh5gOOQhfVEAtbzVHhav8LHdRszBeVVh
	ldkwhfotZTdkbu2rugTyI4BjkaDRb/EFXIlpGeZFWIwb3rR0JerQxhEaj+Jm
X-Received: by 2002:a05:6a00:b49:b0:89f:37a0:b2cb with SMTP id d2e1a72fcca58-8a089eba62amr2905819b3a.49.1792635742236;
        Wed, 21 Oct 2026 19:22:22 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0894b4206sm1450303b3a.18.2026.10.21.19.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 19:22:21 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Oct 2026 02:22:20 +0000
Message-Id: <DMB0C24NTIST.YQZ2Y3E0I1I1@gmail.com>
Subject: Re: [PATCH bpf-next 9/9] selftests/bpf: Test uprobes and fork()
 with busy mmap_lock
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <oleg@redhat.com>, <peterz@infradead.org>,
 <mhiramat@kernel.org>, <jolsa@kernel.org>, <akpm@linux-foundation.org>,
 <liam@infradead.org>, <ljs@kernel.org>, <surenb@google.com>,
 <david@kernel.org>, <vbabka@kernel.org>, <jannh@google.com>,
 <hughd@google.com>, <kees@kernel.org>, <mingo@redhat.com>,
 <tglx@kernel.org>, <x86@kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-perf-users@vger.kernel.org>
In-Reply-To: <sashiko-outbox-180860@kernel.org>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com> <20261022015712.1297331-10-alexei.starovoitov@gmail.com> <sashiko-outbox-180860@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 21, 2026 at 07:10 PM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>> +#define AREA_MAX	(64UL << 30)
>
> [ ... ]
>
>> +	area = mmap(NULL, AREA_MAX, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
>> +	if (area == MAP_FAILED)
>> +		goto err;
>
> [Severity: Medium]
> In tools/testing/selftests/bpf/prog_tests/uprobe_busy_mm.c, does AREA_MAX
> overflow on 32-bit architectures when passed to mmap() in hold_mmap_lock()?
>
> Should AREA_MAX be sized appropriately for 32-bit architectures as well?

No. uprobe_multi link is 64-bit only.
bpf_uprobe_multi_link_attach() returns -EOPNOTSUPP on 32-bit and
three of four subtests attach with it.
