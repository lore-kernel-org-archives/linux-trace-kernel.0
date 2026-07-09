Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F1F3EB818;
	Thu,  9 Jul 2026 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588401; cv=none; b=VpaEKGD7XeFq5KeHQ+SQpqI/xJJnEGbDcGwDBIoagkWXPp9zDPt4u0Z9eAyBirOrjcErVJqUkyoZRjuxwdq44XH/pqDCMm1OvOhUmCKlKTgSrgPH9K91LdaP6+I58Yujzm4AUbt9IU8KhBDW4uJx71P6zyqrd5dvD9tFGbATDTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588401; c=relaxed/simple;
	bh=WuaVUSYZ3uOq4v5GKVtHehv5ikq9MRAhRSdd5fVXxdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBcsCxv4NaakaxbHMSmIU6ihZBr5heZhvL0gDWp42HiL5UpdkEmiVHoceTp+xpVL2zBOECE5wP0GdhOHBbR/oUIBLYz+y5JLKjXpcTqlCOUFo9gOXxMwSUGOWLGXbaaA4i63ZpgL53agf9b9cuaTo5K4aAG1VXLlQz7Kkcy8K4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=guIrbCG2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1FqZ4Glp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="guIrbCG2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1FqZ4Glp"
Date: Thu, 9 Jul 2026 11:13:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783588398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oFkhovupFuB+0rzcV3/Rh8Yfa4/ndsw3Kaki+DTqEk0=;
	b=guIrbCG2tFjNemmIWTWaeYkEEVw96TgbMZ/9sp+L9Zu4pxOJuXjszNyLZk5UCalt1MZeFk
	J4EUN+jbwE7bJEVdDFjrpygx7YtwM8CDq7w1Z3deoFVIUMCbWioPu8pBqB792z8DmyzX+8
	eZBeGE80HL4zj+f8UIcazq9FS3G70IvCkWxkoY37YrTX9yl33P0e01MqoGjfcZaoekXiC4
	4kIGWf9nlf8H5YCgNR66/sUxWEa/c0K2Rp77uYnpMPk71hEcBe3XJVXLPEezX4hSlCHwwA
	dBJSbO/YG4q/vIKPNsT1gWZFNwqeZD5VfwqUTZtzxi1fTUDVXrrSMTh9v8pRrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783588398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oFkhovupFuB+0rzcV3/Rh8Yfa4/ndsw3Kaki+DTqEk0=;
	b=1FqZ4GlpMtrrBtqzEJlHdoI4seB5yz2jzvAcIEnwg8F9aO5ZT07ZTCZyXqq5nTBv7j96/e
	bB4kfk2g2ag5sACw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Wandun Chen <chenwandun1@gmail.com>, vbabka@kernel.org,
	david@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
	Alexander.Krabler@kuka.com, hughd@google.com, fvdl@google.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	akpm@linux-foundation.org, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	riel@surriel.com, liam@infradead.org, harry@kernel.org,
	jannh@google.com, lance.yang@linux.dev,
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	pfalcato@suse.de
Subject: Re: [PATCH v2 4/4] mm/mlock: migrate folios out of CMA when mlocking
 a range
Message-ID: <20260709091316.TFgtBZlE@linutronix.de>
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
 <20260707125925.3725177-5-chenwandun1@gmail.com>
 <ak0OZKzapUefmA3v@lucifer>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ak0OZKzapUefmA3v@lucifer>

On 2026-07-07 15:54:57 [+0100], Lorenzo Stoakes wrote:
> On Tue, Jul 07, 2026 at 08:59:25PM +0800, Wandun Chen wrote:
> > From: Wandun Chen <chenwandun@lixiang.com>
> >
> > The region covered by mlock[all] may contain CMA pages. cma_alloc installs
> > migration entries in the page table, if a memory access occurs at this
> > point, it must wait for the migration to complete, which may cause
> > latency spikes on the RT kernels.
> >
> > Try to move the migration cost into the mlock[all] caller, which is
> > typically a setup path. So reduce the chance of latency spikes on RT
> > kernels by migrating the currently mapped CMA pages out of CMA region.
> 
> 'reduce the chances of latency' so do you have any data to back this invasive
> change or not?

The application gets pages assigned which belong a CMA area. If the
pages are in need by the CMA then those pages are replaced with other
pages during a migration phase. Since there is no guarantee how long
this will take and is also subject to general scheduling in the system
it will be measurable and painful once hit.

> And for RT, but nothing in here at all checks for RT? You're using this
> compaction sysctl as an RT check somehow? That's gross.

The man-page for mlock says that it guarantees to stay in RAM and/ or
preventing to be moved to swap area. I would however argue that
replacing physical pages in the background should fall under this since
the application can't access them and is blocked while trying. The notes
section (in the man-page) lists "real-time applications" and
"deterministic timing".  Therefore I think it makes sense to do this
unconditionally for mlock areas regardless of the sysctl knob.
Security related application probably only care that their memory does
not hit the swap area and probably wouldn't mind 10ms delay.

> This doesn't feel like the right solution.

Sebastian
