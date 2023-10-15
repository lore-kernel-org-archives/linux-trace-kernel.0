Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF0F210A
	for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Oct 2023 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDl7yNAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A65C433C7;
	Sun, 15 Oct 2023 15:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697384643;
	bh=DUAnHWX+Ue4CkILaJ0Ej5k4BATwuStu6Tz8sQsViRsg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iDl7yNAVuocCvu6LH3sx0aSjWGacP3jMAwE/jHnBF6RZ0hzifXuzEM4MFWXLA0B3f
	 2Cs19IxiX3aJZSu7XN8D55VaN1VWvTA20fZd+2tbqfEERLBcLNKMCCJ1IZMksVNO2v
	 0/NarFugMppXFUBVFV1bx/vX4TIyEIi3GRLhBIgoCaKIOYeu0U7aq/7VMmttBkYIT2
	 GjXwyTxMpNFp0ly9Ppd9mhW3mN6vooUicChWH3Icwrny8oKPoFUvW+2iR3JJ8F0TvI
	 H2xAJPukgyW/sArdeWC84cmvzvVVg5cAhN5eefSLOaDNeVQAk8bSMqp7jjxPzkC4cE
	 gmhhuPeKn9gXA==
Date: Mon, 16 Oct 2023 00:43:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc: linux-trace-kernel@vger.kernel.org, davem@davemloft.net,
 anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
 rostedt@goodmis.org, peterz@infradead.org, akpm@linux-foundation.org,
 sander@svanheule.net, ebiggers@google.com, dan.j.williams@intel.com,
 jpoimboe@kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com,
 mattwu@163.com
Subject: Re: [PATCH v10 1/5] lib: objpool added: ring-array based lockless
 MPMC
Message-Id: <20231016004356.b5f3f815cb8d7c0994934332@kernel.org>
In-Reply-To: <20231015053251.707442-2-wuqiang.matt@bytedance.com>
References: <20231015053251.707442-1-wuqiang.matt@bytedance.com>
	<20231015053251.707442-2-wuqiang.matt@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Oct 2023 13:32:47 +0800
"wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:

> objpool is a scalable implementation of high performance queue for
> object allocation and reclamation, such as kretprobe instances.
> 
> With leveraging percpu ring-array to mitigate hot spots of memory
> contention, it delivers near-linear scalability for high parallel
> scenarios. The objpool is best suited for the following cases:
> 1) Memory allocation or reclamation are prohibited or too expensive
> 2) Consumers are of different priorities, such as irqs and threads
> 
> Limitations:
> 1) Maximum objects (capacity) is fixed after objpool creation
> 2) All pre-allocated objects are managed in percpu ring array,
>    which consumes more memory than linked lists
> 

Thanks for updating! This looks good to me except 2 points.

[...]
> +
> +/* initialize object pool and pre-allocate objects */
> +int objpool_init(struct objpool_head *pool, int nr_objs, int object_size,
> +		gfp_t gfp, void *context, objpool_init_obj_cb objinit,
> +		objpool_fini_cb release)
> +{
> +	int rc, capacity, slot_size;
> +
> +	/* check input parameters */
> +	if (nr_objs <= 0 || nr_objs > OBJPOOL_NR_OBJECT_MAX ||
> +	    object_size <= 0 || object_size > OBJPOOL_OBJECT_SIZE_MAX)
> +		return -EINVAL;
> +
> +	/* align up to unsigned long size */
> +	object_size = ALIGN(object_size, sizeof(long));
> +
> +	/* calculate capacity of percpu objpool_slot */
> +	capacity = roundup_pow_of_two(nr_objs);

This must be 'roundup_pow_of_two(nr_objs + 1)' because if nr_objs is power
of 2 and all objects are pushed on the same slot, tail == head. This
means empty and full is the same.

> +	if (!capacity)
> +		return -EINVAL;
> +
> +	/* initialize objpool pool */
> +	memset(pool, 0, sizeof(struct objpool_head));
> +	pool->nr_cpus = nr_cpu_ids;
> +	pool->obj_size = object_size;
> +	pool->capacity = capacity;
> +	pool->gfp = gfp & ~__GFP_ZERO;
> +	pool->context = context;
> +	pool->release = release;
> +	slot_size = pool->nr_cpus * sizeof(struct objpool_slot);
> +	pool->cpu_slots = kzalloc(slot_size, pool->gfp);
> +	if (!pool->cpu_slots)
> +		return -ENOMEM;
> +
> +	/* initialize per-cpu slots */
> +	rc = objpool_init_percpu_slots(pool, nr_objs, context, objinit);
> +	if (rc)
> +		objpool_fini_percpu_slots(pool);
> +	else
> +		refcount_set(&pool->ref, pool->nr_objs + 1);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(objpool_init);
> +

[...]

> +
> +/* drop unused objects and defref objpool for releasing */
> +void objpool_fini(struct objpool_head *pool)
> +{
> +	void *obj;
> +
> +	do {
> +		/* grab object from objpool and drop it */
> +		obj = objpool_pop(pool);
> +
> +		/*
> +		 * drop reference of objpool anyway even if
> +		 * the obj is NULL, since one extra ref upon
> +		 * objpool was already grabbed during pool
> +		 * initialization in objpool_init()
> +		 */
> +		if (refcount_dec_and_test(&pool->ref))
> +			objpool_free(pool);

Nit: you can call objpool_drop() instead of repeating the same thing here.

Thank you,

> +	} while (obj);
> +}
> +EXPORT_SYMBOL_GPL(objpool_fini);
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
