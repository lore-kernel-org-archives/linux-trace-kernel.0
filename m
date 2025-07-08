Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5F721B905;
	Tue,  8 Jul 2025 07:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751958650; cv=none; b=oBUsSDtOqXP394Eqk4EH3JHyGCMInOYDt19zHPDxScqxPh++YFYzv4UE3eaqoE7JDtDMvDa87tpzREF4VdLfjiZ1Nn9F5+hX3SuXZmR+9xiFSFhLdd3o7bDvrJoV6VCAHOwyBFWNlwe+JmVE7PTjffafwhQfPIrWlfRKQU+NKKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751958650; c=relaxed/simple;
	bh=CC5iDx0Wrj+Klrk9Ri4aS+NjdvqOQWWSjSxWvVcXFTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAZYEYU4o4MPwLnbKG5faXn9UD4ztAsSI10rCJgqmAFDShPZVcOynsrB5TTNL+xXStUVeZENzpTzWV1/lF3EO/CLTGB24xcAbDPDZanAQpFAEtvAahsstwCIHQMWu97orMipvag4wiG9lrJoRyAhGCb0KpL9MjxS2Aj4NYW3k1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afTs5ENv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afTs5ENv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90835C4CEED;
	Tue,  8 Jul 2025 07:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751958649;
	bh=CC5iDx0Wrj+Klrk9Ri4aS+NjdvqOQWWSjSxWvVcXFTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=afTs5ENvhkamb0LLqd+IgEiyQGBJe90QeMYZYjcrMkTNC8Yu/NUAMmEf9niXbRH7a
	 mYJWapF7+xQckyQVQmHOifdktVPPFNQniSX4nriWuNq61s3H7R7txv3USrHQ/l1De8
	 XwVHB3FItTDK9gJGT0g8XBRf5UxPYBI5VCtKChiCxSy7sh4Twat/vQu4c5wES8cXG/
	 Qw75thLg7rjQNPPWvLjr9xHmdMxlKoViNHGp6O1/7jjBFU652BDxVZzEiQ/2Pd46u4
	 se56Zl8WSMr/s0TMKrumCoE+CTJ+R8u8BV9TcygQUFtUFgsXl/nJDWWEYtQz6A2BT/
	 wly+OikM25RRw==
Date: Tue, 8 Jul 2025 10:10:39 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Yann Ylavic <ylavic.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 3/8] execmem: rework execmem_cache_free()
Message-ID: <aGzEbw3BybnWOidx@kernel.org>
References: <20250704134943.3524829-1-rppt@kernel.org>
 <20250704134943.3524829-4-rppt@kernel.org>
 <CAKQ1sVN9KZYt=M5cst+BonDMVL_wO3sbhgZ+JPzc=Rw9Qfz9tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKQ1sVN9KZYt=M5cst+BonDMVL_wO3sbhgZ+JPzc=Rw9Qfz9tw@mail.gmail.com>

On Mon, Jul 07, 2025 at 05:32:11PM +0200, Yann Ylavic wrote:
> On Fri, Jul 4, 2025 at 3:54 PM Mike Rapoport <rppt@kernel.org> wrote:
> > +
> > +static void execmem_cache_free_slow(struct work_struct *work)
> > +{
> > +       struct maple_tree *busy_areas = &execmem_cache.busy_areas;
> > +       MA_STATE(mas, busy_areas, 0, ULONG_MAX);
> > +       void *area;
> > +
> > +       guard(mutex)(&execmem_cache.mutex);
> > +
> > +       if (!execmem_cache.pending_free_cnt)
> > +               return;
> > +
> > +       mas_for_each(&mas, area, ULONG_MAX) {
> > +               if (!is_pending_free(area))
> > +                       continue;
> > +
> > +               pending_free_clear(area);
> 
> Probably:
>                   area = pending_free_clear(area);
> ?

Right, thanks!
 
> > +               if (__execmem_cache_free(&mas, area, GFP_KERNEL))
> > +                       continue;
> > +
> > +               execmem_cache.pending_free_cnt--;
> > +       }
> > +
> > +       if (execmem_cache.pending_free_cnt)
> > +               schedule_delayed_work(&execmem_cache_free_work, FREE_DELAY);
> > +       else
> > +               schedule_work(&execmem_cache_clean_work);
> > +}
> 
> 
> Regards;
> Yann.

-- 
Sincerely yours,
Mike.
