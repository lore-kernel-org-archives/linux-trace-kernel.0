Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1826D264
	for <linux-trace-kernel@vger.kernel.org>; Sun, 24 Sep 2023 14:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8121C433C8;
	Sun, 24 Sep 2023 14:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695565311;
	bh=h+by+Bpd3urcZtbmENRkjjPEMFhQuHlQ8ScQxWIt5nI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WF3iltcHUuE60EUwiSfre9imVRIRFagHHoPZed4IDgYUxXm2D7Qpcvn7MRQO8gt+r
	 WERMdkArOlxZ57kreyvIRWi0YuL81ddvlzu2GkI9EbRhpIxuzUyLclf2c1W2OPyPGp
	 s0A7jrx1jwYyky3uKID+vhocl4zQ/SaBuZBP/iQef/j2xfTlHSTB5HQwwgrBQ5NTOc
	 p2CR3IZGSzj+KLwrP0/QwdTmP7E0EQDxQtSFsyQYmM++0ZKZBtbuszk/aNr0d55BRX
	 C064niKvXbM3YykUXgfcOe9NbDs4g3MmH0tw14BmrVk++X8KIHVJNixNI6EH3ztRq3
	 fvoNP7odJtuQA==
Date: Sun, 24 Sep 2023 23:21:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc: linux-trace-kernel@vger.kernel.org, davem@davemloft.net,
 anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
 rostedt@goodmis.org, peterz@infradead.org, akpm@linux-foundation.org,
 sander@svanheule.net, ebiggers@google.com, dan.j.williams@intel.com,
 jpoimboe@kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com,
 mattwu@163.com
Subject: Re: [PATCH v9 1/5] lib: objpool added: ring-array based lockless
 MPMC
Message-Id: <20230924232145.05efde741742e24f3f4fd032@kernel.org>
In-Reply-To: <20230905015255.81545-2-wuqiang.matt@bytedance.com>
References: <20230905015255.81545-1-wuqiang.matt@bytedance.com>
	<20230905015255.81545-2-wuqiang.matt@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Tue,  5 Sep 2023 09:52:51 +0800
"wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:

> +/* cleanup all percpu slots of the object pool */
> +static void objpool_fini_percpu_slots(struct objpool_head *head)
> +{
> +	int i;
> +
> +	if (!head->cpu_slots)
> +		return;
> +
> +	for (i = 0; i < head->nr_cpus; i++) {
> +		if (!head->cpu_slots[i])
> +			continue;
> +		if (head->flags & OBJPOOL_FROM_VMALLOC)
> +			vfree(head->cpu_slots[i]);
> +		else
> +			kfree(head->cpu_slots[i]);

You can use kvfree() for both kmalloc object and vmalloc object.

> +	}
> +	kfree(head->cpu_slots);
> +	head->cpu_slots = NULL;
> +	head->slot_sizes = NULL;
> +}

...

> +/* drop the allocated object, rather reclaim it to objpool */
> +int objpool_drop(void *obj, struct objpool_head *head)
> +{
> +	if (!obj || !head)
> +		return -EINVAL;
> +
> +	if (refcount_dec_and_test(&head->ref)) {
> +		objpool_free(head);
> +		return 0;
> +	}
> +
> +	return -EAGAIN;
> +}
> +EXPORT_SYMBOL_GPL(objpool_drop);

To make this work correctly, you need to disable the objpool (no more
pop the object from it) and ensure the objpool is disabled.
Also, when disabling the objpool, its refcount must be set to the "active"
number of objects.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
