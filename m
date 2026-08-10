Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60B03AB28E;
	Mon, 10 Aug 2026 11:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786360983; cv=none; b=KrsAy1ubMZYeH/MWUDrQCbnaM1Jayh7PuxVYDx5VHk63IPZ4jCiS3+VTe0RS9J6s83svPS8VYEs7io5AqaqWO4G5JgKFcA6eyODV0PXBNQNBmTZ7E6qnb1uEptXDhHOm+InafmbhlSCa3Nsvlm/1xY1Yw5BdHiCrfgiMD3cisxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786360983; c=relaxed/simple;
	bh=eesWqef+s8ssBuhLiDAIXIO1iqDPsSJGwT8bTKksJuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wa0izzN1Jvsp9ri4hZpJ7d1Z47Xwy3RZN5w4UGxKLZXa4OVLkseFcsCxsqDP4DL7Gwwz327mBJngCTa6nFMmiRrhDKpRT5H3RWj4k+Gxk5dNMmvgHJ5VWDnbB2aPyZso52q4gCI+ErAuGcuvt0FEIZsjf9mN4DVsLacGoL7Zkok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRwt30jt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRwt30jt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3941F000E9;
	Mon, 10 Aug 2026 11:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786360982;
	bh=eesWqef+s8ssBuhLiDAIXIO1iqDPsSJGwT8bTKksJuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DRwt30jtwAkajLVWCwdOBKb12YYFw8pu2d2GnIsZg9cXJ6hJGeFXnQN3yRWBO0BFp
	 U5W2Bs3KwF2sSJgDLe583LTl4Xz8YVMZ//eGB4ci6yQvdmz8rMuLS4HXaTxPnIj1PX
	 wA1TrFSOi7E6w/9Vnv3hd5BeDXh3peJQZY670//SXB2x2jExtizL3AycLxadDz0U0q
	 wmL+9GsU2DGlPm0FgS1lZvlO+h1ICn7ov6ctnS4amJgl20eNTLTpMnauV8EBmY2o1F
	 HaLGXAWkS+5ymxHDEOMadxsy8F3QF4wx2ezvy0MVx8ldZv8Ij74Bo+Qi/Bod+6h3nX
	 ABuJh67+3DksQ==
Date: Mon, 10 Aug 2026 12:22:43 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Xiang Gao <gxxa03070307@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	liam@infradead.org, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Xiang Gao <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH] tracing: report buffer memory in /proc/meminfo
Message-ID: <anm0SMuVpBz7wLac@lucifer>
References: <20260810094025.136705-1-gaoxiang17@xiaomi.com>
 <69df3080-a719-4131-a247-62bf47bda8a6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69df3080-a719-4131-a247-62bf47bda8a6@kernel.org>

On Mon, Aug 10, 2026 at 12:52:38PM +0200, David Hildenbrand (Arm) wrote:
> On 8/10/26 11:40, Xiang Gao wrote:
> > Report the data capacity of all ftrace ring buffers through a new Ftrace
> > field in /proc/meminfo. Include the main and snapshot buffers of the
> > global trace array and all tracing instances, while leaving ring-buffer
> > metadata accounted for by Slab.
>
> why? :)
>
> To report a handful of KiB as in your example below? Doesn't sound super helpful
> TBH.

Yeah I think we need to stop with all the proposed additions to /proc/meminfo :)

Also something like this where you are making a change in output that it is just
your opinion that it is useful should be an RFC to see what the community thinks
first.

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
