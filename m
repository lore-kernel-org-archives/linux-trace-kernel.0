Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461790;
	b=MAWYzqRN4DLtKnhjk+WzeCebph3JhLCkYka4aSW201W2Lqubp55XfTpD2LnQtIZmDIA3
	 oc9APTrNP3nV2F1aIu4XlH/n6qaX3wtL3JxzK6SV9uB8GA0V3atPgEWapOlWrP5pQzKHj
	 Ki1wHCNneJ4vfCw7phAgkdXS9aC9jaTue1g8ksETKb76TxDXg/3rukDhkywmCHUvdbWp3
	 xJdN6rz9wC/9ea48WCvtuhLZ/q98aF/+TgWNlXj9aj/Icdw4wlSn4Fdj0ZW2XRLHCgzsa
	 rX9fy+d8tyervR9HGPcYkvR8i8ovZE/JaHBu4B2VO+PEXxPIISSchv9erajdfyH1uBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461790;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=e2soeXJ852281gC+OC2yZSX9G2s4v3lG9pbKt+VP0DM=;
	b=D8byIHhJtus3tc5e1oRHe7YdJeE0OhXn5VQK7Ra0mvd8WaZo8VJw/cdqCB7T/+ojoUp8
	 JRXBddW6zG6zau3vDNclAtKuHOuZRn5P2VNaE1MTAdLNIVazWJGXu7ttyBRsUBaRzIRRP
	 236HEp0dJRTouoWnt231Bp6QvMqC/x8OMV5toy0XazoDAR8z7TVARPjVovPsk8kKUuGZ9
	 diPvEDL1VrmLtZZZkoO2sOY7OGJGTrdCokz+L5n7/UXxdqlUhZNi+8iDCwsV4xiYF1mB+
	 R8aVm+gvPytsob6wWsMTg+RrksGIAStu5CgcpD6B9iL4BnQETJufg4LUK80bSBP8e2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EzLeINlq;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7A1606A331
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 05:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E7A1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EzLeINlq
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-94937a33cfbso25596885a.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 21:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794461788; x=1795066588; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e2soeXJ852281gC+OC2yZSX9G2s4v3lG9pbKt+VP0DM=;
        b=EzLeINlqWKLSrVyAYeG69cub/PpkhXEpvLI85c2/Wn4DBrX36De6eOjOc825yh2/s8
         /BMocYYbFGCIGlSENImF1edskqevAV/Kuf1SeaFnM5vAAp8DG8IO1FgayCsUEWs73OHL
         1RmURtZJc9D4dd17Nf7TyLA18R4yata5cpiLNB4SZ3wXp+wb6mfksV9V6NYOJLevPnzx
         KS0lFdrtd+eUvcxCI5cIGAuAdA3+x/lK/g0n6XOLpuLtAwXE7FSdI5GYz16DwRhEZcI+
         e0xi/xTmcXSNKhZMTs2dmsnafffo4Jcsb0EhR1rdi49ZUTTTqLCosCyqFBij3UK+VNvA
         tckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794461788; x=1795066588;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e2soeXJ852281gC+OC2yZSX9G2s4v3lG9pbKt+VP0DM=;
        b=kbdya1MlR5ZU4pufvnwxXfdczfVM8PHnGwnFQ1+jzuwqihGhYHxQcagLpmzEUvNpzR
         8rAe73o+Ogkd9pRwff6Ru9u7xz02yP7/e0mIFoDZuSoadaHG4uQFHDwrsAvnIKFW9fP5
         fTJx7nEYmtYHduDjm34BojtaooYCQMmslkZR1v9ZzbxYfRgA16zf722TcmSGHryq9q0O
         uV3b1Td6uc9nCYyUWruXmao2G3c7G85FoF4IMAWPhsOY5/6pXs/hPmatQiQEKCgIX+FO
         uM4Ig/athVH1liaJZifVX+TPagZ5PEjYvLH4ovtvRikDgodMg7tpwJ94n9/B4ziG1yK2
         yKlQ==
X-Forwarded-Encrypted: i=1; AL+hErFT638DLJId3IIQJC5eGJNoUIcNLukXVnUJnJ7HWUeEucRojEqii4cbJl3p5JOzb+fSvyjaqbGIajN+xduQRFA/6QE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SQk2fGyumbc1Bkk9DORkojSyBqE9F9EWCsV++Ya64GaH6tvr2
	gl/0hfSP1FRcV/yP8aGQ4YqPZK423JkacrfkACWtaxif2nuDXT2t4azVB3kL91IyfnM=
X-Gm-Gg: AYBFou1RJ21yZv5Vd1q7aYfJGnsjBq7j6xVvUqJyvijjlROmVaPBW8/pWK9OPFBHoSA
	kbzREa/NnS5jn8XgFiCU+Ho0FTd+yVhptAiDZlLyzoOvqVvX2QIkTIOs/p1ucwgvqp8lu51gJ+P
	IGLif/Dx1U5oqhXNA09JVmUghRLW+8jIXuzCLxi4nR820JYHJSm7g4eNtmI9A4n4EToNaSCujIZ
	Zr487Rrm6C3Ah9imMUZcgWNUCjmwREEFepFmOMtysuPbKqMqirs/OK7ix/TrYe8vKyHiEDlK/CT
	5mRa4pTr/mIjO9XE0v5yA9e0PRKe2YsRU6BCMRG41c/3kAbzgKVy6meoCk7n7Gbs308zj2VG/S0
	xNrO7XX2CtO/iEOECMYh3s5jJ80/SCivQYHw93r9p5dndD6YWJF5e1opgSClBC9Fq8KmbzwFSMd
	LROhOp3WOMfgPQlNNBvXVDpsKOoD3FDPckj5iq24RKFPpu8GAZWIqsBhI01BkXlqlmvh0eRg8iK
	dDY1Y2xJX2yk40Yf8fVqv66sVSkaJkOMnRc/CUpIrZFKgFOIzaIkd7/Jfee+sPXTyEknu7rAWJq
	fQrh/vyViCt1K7Y2ZdjTKggNf38+25ewBkG+SK6uMq1faW61yphdy2M60V2I+nzePnu/hpCAWZu
	n0/xyhJw=
X-Received: by 2002:a05:620a:4481:b0:93c:c2c2:40eb with SMTP id af79cd13be357-947b0046fb4mr764496385a.66.1794461787830;
        Wed, 11 Nov 2026 21:36:27 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e4fa312sm647786285a.0.2026.11.11.21.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 21:36:27 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 08/13] mm: convert miscellaneous VMA flag tests to use
 vma_flags_t
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
 SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, 
 David Rientjes <rientjes@google.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 John Johansen <john.johansen@canonical.com>, 
 Georgia Garcia <georgia.garcia@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 kvm@vger.kernel.org, damon@lists.linux.dev, 
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261105-late-2026-vma-flags-v1-8-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-8-0d3cd15ab75f@kernel.org>
Date: Thu, 12 Nov 2026 00:36:24 -0500
Message-Id: <179446178440.482102.12362401790016415292.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-05 21:30 +0000, Lorenzo Stoakes (ARM) wrote:
> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> remaining straightforward VMA flag tests scattered throughout core mm, HMM
> (and its test module), DAMON and the OOM reaper.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Acked-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

