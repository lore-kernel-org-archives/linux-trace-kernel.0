Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483522AE86;
	Tue,  8 Apr 2025 21:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744148815; cv=none; b=RBOn5a2cER8iNDm4AECc66xBwJ5lSfB4Ugs9kVxI7Ix8/OXVLC3ZFkt7fBwbMuvu6gxGpmaDMbQqe2NioXULK4iFIUS+Eb9TNxCRcAY6R9mwpMoBsnaNa6HWQGpD+mp2QmgAokkJKPqvhqHpGsqJ5qCWEzoF4knAI4+xjAElyIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744148815; c=relaxed/simple;
	bh=1CdAX/Vmooyt36OrpOM3FfcJ8S7Qqx8DS2vhZPGpQxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZZ7/rQA8nrqc+nXEiABC9WmLkoU8ojqAGcs3BLvx87KGQKFgrXuLgAI11qsZtYwFLAyB5yKnCew0ycsdTPaoooCPedxLd0pDQiqhdbq87vD/bJQywVRr+ezNl/VUnWEMfYyTK1Oa7RYQwuXxfVwTs/vxN/xPy/bw1Ndbq3Pv0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHzBe7Ah; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHzBe7Ah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A651CC4CEE5;
	Tue,  8 Apr 2025 21:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744148813;
	bh=1CdAX/Vmooyt36OrpOM3FfcJ8S7Qqx8DS2vhZPGpQxk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=RHzBe7Ahi8SWAAKvssPgiUVjk4o5e6hl9o3XPI7cMA+N4NaGuw2u5qgL2crXGiIBr
	 zWMkZA0akpNat/jb4ZTbQ9Z/U5TTNiyVDJGfrVkQ7LGOcaOp+b/6MXXI6GM19fqRx3
	 KjyV7TtSi7UjABbLWNGLQAacqVKtXMw0fsAaANg+phXp8669HhEfY69f/8o0prYDEw
	 MEpSIy8eZyh8ajc+/wFM6+Wj5LT+4GB4r14PtamtAqTslvZfKagwhwClZsoaaTVcij
	 pTb0CLCBMH7kaxgf9vRsbojxaB/2Ax2/2563qCP+mpfa7CYGoyFJ3PbQ5l3dz55Ozs
	 kD8o8INbW70OQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 473FDCE0F64; Tue,  8 Apr 2025 14:46:53 -0700 (PDT)
Date: Tue, 8 Apr 2025 14:46:53 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sweet Tea Dorminy <sweettea@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>, christian.koenig@amd.com,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH v2] Introduce Hierarchical Per-CPU Counters
Message-ID: <077bfec0-c918-48b1-b133-36b4bba5d66a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250408160508.991738-1-mathieu.desnoyers@efficios.com>
 <f90d7646-99a3-48f5-ba2e-850c73592080@gentwo.org>
 <f014a9bb-0653-4682-8608-7fe6e2ad5ee6@efficios.com>
 <c013632c-b4ca-fb3d-9be5-b02ca5a3d859@gentwo.org>
 <9f42144b-dca9-41b0-a80b-2e402cb5ab98@paulmck-laptop>
 <8897b4e1-b5ba-807d-7bc4-5a6080a93462@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8897b4e1-b5ba-807d-7bc4-5a6080a93462@gentwo.org>

On Tue, Apr 08, 2025 at 02:21:59PM -0700, Christoph Lameter (Ampere) wrote:
> On Tue, 8 Apr 2025, Paul E. McKenney wrote:
> 
> > RCU handles this by iterating from zero to nr_cpu_ids, which is set during
> > early boot.  It also builds its tree-shaped data structures during early
> > boot based on nr_cpu_ids.
> 
> nr_cpu_ids is better but there are funky things like the default bios of a
> major server vendor indicating 256 or so possible cpus although only 2
> were installed. Thus nr_cpu_id is 256. Presumably some hardware
> configurations can support onlining 256 cpus....

Indeed there are.  So some portions of RCU build for nr_cpu_ids but
activate portions of the data structures (e.g., spawn kthreads) only
for those CPUs that actually come online at least once.

But should we really be optimizing to that degree for that sort of
breakage?  Just extra data structure, who cares?

Yes, I do understand that the vendor in question, whoever it is, would
not consider their default BIOS to be broken.  They are welcome to
their opinion.  ;-)

							Thanx, Paul
