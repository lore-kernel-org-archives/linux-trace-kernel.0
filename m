Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793948607;
	b=LqG5pc8aop6kjFJT+aPX/WoCgrspLE8Elu6/1uulTsDdIHP2kksGXoYXqxW0H3muikRr
	 9q4Nc5PtJf9fx7p1dmiAPR/vnsbE+1LBtWNN3SvckL+P/s+XSPDtqKrL5LaeckdiE9I18
	 CUSqBf5Y6DXAlitRcpgFNA4f42dSxxQHBksO9LNWDc5RcIGqNj4QMW+AxKTTxNN1B1poG
	 CJy3mCONaBtp+GtJXMNdk/ZmAuLz0azsn0nAA4SQRZ8+PfoqGGG2FxT22qre/g2Hx5qMi
	 Ubcehhr+5jya5HFaPiwx323Xo3Q744Kc8SJ+lnf9kbpJESE3K26KnHQ4wc4E6NV9Ibw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793948607;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mO1x09i7EnqPJXUwKJeExoIzGQZI3rHtjjcSVoEtSSw=;
	b=FUXGjQkyXUyfJvBCzVX8dmP4oEuveabRmr7A86r3ej2+eggnMDgPL3+hlek/m3xF8XcM
	 RMoYgdGtyU+r6FI4zIgSiNYdW5wHk25EyiOzpR7RBqlqaTDGGufbuEq7poeahmd1d1SSP
	 ofbvPOakKFtbZ6+AsZ7uWOXW5/sNYYoxh1XsaYItUm3OgcTS1yMK2Ek0A49OKkbQNtRfT
	 RcTfZVvxUMC3mLaeT+mskPxKZPbwZ2D+lV8nyBnUJ/Q1wD0aLGlw1w59KtiS8Np2cr9kt
	 vgbAjWb/G4DaPPI4gJngjD1fwtDDgZwOxedNQ79REcK7MOFaqEvDb2gu40+pZffF0Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uiwzP25s;
	arc=none smtp.remote-ip=91.218.175.49
Received: from mta0.migadu.com (out-49.mta0.migadu.com [91.218.175.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3DD606D808
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 07:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D3DD606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uiwzP25s
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mO1x09i7EnqPJXUwKJeExoIzGQZI3rHtjjcSVoEtSSw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793948598; v=1; x=1794553398;
 b=uiwzP25szE8R7aqwL388yrOGTv4U7r4B7Y+aJmsOhGmpEl56nTTtuloHNeYlDagsG39M4UYY
 XetFr7qaoASJXkzEHaDo9hMiWjLXhWiSoc/Hdsj1Ki1gHf1h2PBDIQYM4H40LzPWFZJSdCg7FEh
 dxsCHwwGutxk8toJZnLqaDQc=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 54b6ffc0bb54435e;
	Fri, 06 Nov 2026 07:03:15 +0000
X-Mizu-Trace-ID: 54b6ffc0bb54435e
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	willy@infradead.org,
	jack@suse.cz,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	maddy@linux.ibm.com,
	npiggin@gmail.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	pfalcato@suse.de,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	leon@kernel.org,
	sj@kernel.org,
	rakie.kim@sk.com,
	rientjes@google.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	mhiramat@kernel.org,
	oleg@redhat.com,
	john.johansen@canonical.com,
	georgia.garcia@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	wufan@kernel.org,
	stephen.smalley.work@gmail.com,
	omosnacek@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH 10/13] fs/coredump: convert vma_dump_size() to use vma_flags_t
Date: Fri,  6 Nov 2026 15:03:07 +0800
Message-ID: <20261106070307.51561-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-late-2026-vma-flags-v1-10-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-10-0d3cd15ab75f@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Thu, Nov 05, 2026 at 09:31:01PM +0000, Lorenzo Stoakes (ARM) wrote:
>Replace use of the legacy vm_flags_t flags with vma_flags_t values when
>determining how much of a VMA to dump.
>
>The flags copied into struct core_vma_metadata remain legacy flags as they
>are consumed by the binfmt handlers.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Nothing jumped out at me, so:

Reviewed-by: Lance Yang <lance.yang@linux.dev>
