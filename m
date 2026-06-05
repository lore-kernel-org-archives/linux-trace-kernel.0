Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C609C3B71C7;
	Fri,  5 Jun 2026 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780652272; cv=none; b=YC4u+pVWCfBuu3mhtUrCCF8EJ0PsdYZElunmMUPjXj/A6r0uQLTFvoK70UqRV52hm5YwjOzgFYGVSwdvg7xJO5M65zuP7HOnUxSQ2ViWsPUgy6QSM7qD9VmO3YfB07Vt6cHj+zaS1Mw30By3VWlseWWKDu3JNTo6Ub69whT8Pl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780652272; c=relaxed/simple;
	bh=8cBYiMwip8lAKF87Y/UQxolXd+bSEKiOZHuBrKRpgEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKlsr0UF8WbW3Sa/gvK56q7tJtsekoQTIY/pyY39WoDC3DlgRZkdIbljt6D6ELLRpcl0A5DIbjyKVeLi/FK7C+ZAh0tM6Pj0x5OguC14dsiNaqGaOBeTZg0YE/2ZJG71eepcf0dXizjrkIWcWsruCwT/fHg3Y/2DjA/BA3LteCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=HoAyQpAd; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="HoAyQpAd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e84QUmeJSE8evcwDBPyvsbmrCzkZyJlvZDf/jrq/0lM=; b=HoAyQpAdz43G5JIm3qfXgiGA3Q
	RYaencs/IDR9pJlLxEGrRRDs173Cg4cS/7hlFAerKRcguaUaCB13UwA6hdU3k09h4dZkpZ+zTSSk6
	d+fvwerT20b4PIpYFiUo6EQEBffvAaH6beBEAxta39svbOoFjCliJI+iqak/C2QBVe/UGc+yNss4o
	LmTQ/KEiaCWG9YhPbkmpfE+vOEcLSe0ijpMECaL8OjByFPPTUJPT6s8jtme/wyeLDGeP3jHt5YpPZ
	ClIYaScB1wv+RbOHgVXcSpCZuYlwlZT+pODdxZ78rFL4HJwmpB29pIjz1IF3QVtf2aziL/dmZDruT
	3LT1WHxg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wVQzo-005CGM-1M;
	Fri, 05 Jun 2026 09:37:44 +0000
Date: Fri, 5 Jun 2026 02:37:38 -0700
From: Breno Leitao <leitao@debian.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>
Subject: Re: [PATCH v8 4/6] mm/memory-failure: add panic option for
 unrecoverable pages
Message-ID: <aiKYvU0BpClpykCa@gmail.com>
References: <20260527-ecc_panic-v8-0-9ea0cfa16bb0@debian.org>
 <20260527-ecc_panic-v8-4-9ea0cfa16bb0@debian.org>
 <4d7b720a-7975-8a4d-a00e-e888d63812a0@huawei.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d7b720a-7975-8a4d-a00e-e888d63812a0@huawei.com>
X-Debian-User: leitao

On Tue, Jun 02, 2026 at 03:05:32PM +0800, Miaohe Lin wrote:
> On 2026/5/27 22:06, Breno Leitao wrote:
> > Add a sysctl panic_on_unrecoverable_memory_failure (disabled by
> > default) that triggers a kernel panic when memory_failure()
> > encounters pages that cannot be recovered.  This provides a clean
> > crash with useful debug information rather than allowing silent
> > data corruption or a delayed crash at an unrelated code path.
> > 
> > Panic eligibility is intentionally narrow: only MF_MSG_KERNEL with
> > result == MF_IGNORED panics.  After the previous patch, MF_MSG_KERNEL
> > covers PG_reserved pages and the kernel-owned pages promoted from
> > get_hwpoison_page() via -ENOTRECOVERABLE (slab, page tables,
> > large-kmalloc).
> > 
> > All other action types are excluded:
> > 
> > - MF_MSG_GET_HWPOISON and MF_MSG_KERNEL_HIGH_ORDER can be reached by
> >   transient refcount races with the page allocator (an in-flight buddy
> >   allocation has refcount 0 and is no longer on the buddy free list,
> >   briefly), and panicking on them would risk killing the box for what
> >   is actually a recoverable userspace page.
> > 
> > - MF_MSG_UNKNOWN means identify_page_state() could not classify the
> >   page; that is precisely the wrong basis for a panic decision.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  mm/memory-failure.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 14c0a958638c..dcd53dbc6aec 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -74,6 +74,8 @@ static int sysctl_memory_failure_recovery __read_mostly = 1;
> >  
> >  static int sysctl_enable_soft_offline __read_mostly = 1;
> >  
> > +static int sysctl_panic_on_unrecoverable_mf __read_mostly;
> > +
> >  atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
> >  
> >  static bool hw_memory_failure __read_mostly = false;
> > @@ -155,6 +157,15 @@ static const struct ctl_table memory_failure_table[] = {
> >  		.proc_handler	= proc_dointvec_minmax,
> >  		.extra1		= SYSCTL_ZERO,
> >  		.extra2		= SYSCTL_ONE,
> > +	},
> > +	{
> > +		.procname	= "panic_on_unrecoverable_memory_failure",
> > +		.data		= &sysctl_panic_on_unrecoverable_mf,
> > +		.maxlen		= sizeof(sysctl_panic_on_unrecoverable_mf),
> > +		.mode		= 0644,
> > +		.proc_handler	= proc_dointvec_minmax,
> > +		.extra1		= SYSCTL_ZERO,
> > +		.extra2		= SYSCTL_ONE,
> >  	}
> >  };
> >  
> > @@ -1255,6 +1266,15 @@ static void update_per_node_mf_stats(unsigned long pfn,
> >  	++mf_stats->total;
> >  }
> >  
> > +static bool panic_on_unrecoverable_mf(enum mf_action_page_type type,
> > +				      enum mf_result result)
> > +{
> > +	if (!sysctl_panic_on_unrecoverable_mf || result != MF_IGNORED)
> > +		return false;
> > +
> > +	return type == MF_MSG_KERNEL;
> 
> Would it be more straightforward to write as something like:
> 
> if (!sysctl_panic_on_unrecoverable_mf)
> 	return false;
> 
> return (type == MF_MSG_KERNEL && result == MF_IGNORED);

Sure, that reads better.  I'll fold the MF_IGNORED check into the return for
the next revision. 


        static bool panic_on_unrecoverable_mf(enum mf_action_page_type type,
                                              enum mf_result result)
        {
                if (!sysctl_panic_on_unrecoverable_mf)
                        return false;

                return type == MF_MSG_KERNEL && result == MF_IGNORED;
        }
