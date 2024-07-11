Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B0C54657;
	Thu, 11 Jul 2024 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720723380; cv=none; b=CiZrlwa4Pg9E0VbpndLelWM0OPHQGNIxwHNQOx2fiZ8Gni66nsKfRU/wPqhPj1aXkyOs+jbdcrpPeglvVGUy5R4XnZ8+IPgtVwrHBYDHKz2S5tUqXw6+32fdP/x2+Eb6UtcCTDEG2sl5IrKCWGoWJeoUNhk9ksNVDf6aO6yp5u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720723380; c=relaxed/simple;
	bh=1VD1l8BcEO5CRrrIhm8LmbatrpLVg5M1IC6hBv4z6uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O44DV9JnZpt+mQlEQbMbFmFcKNrXKL3c2YFDh3cXFy74PDEcl3cOZ8aL/jA4XibzDEDaXeyIVQ3CAp0KKoYZAlVskctXxPPHzzkXB97+HroKYIaX9zawvAUKISDxTCDWmL1P/tAeYVBacSFOvHdpviaZDFuzh46U7fKaVJTjNxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yfg6Xzy2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yfg6Xzy2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bA0o/xfWTMOlDDaHwMD+yUJJ1Reh1OoOCi4t4sZG3qI=; b=Yfg6Xzy2kGAcEr/TfRFSpPb3TE
	M1Z9/F/QJML9QR89+CICNJdYUHpb4fWqXlOBeH3zQRIEoqezFNzFFbnUTAUoqwQaqDBO+oYCSJ2TA
	nlfrNd6RQC7V+gx0kMCdqTeiifkNXYC2SxEpLn3IL9RRJ4NoDHAxoShChBbW5l1hUQe5OqR1//U/T
	trzJeuqGbzoGrfIHkNpzn8CXWbMtKY1qFTWmyo5jSk3cHP4nnwibUOUmiPJUKF7RWAmICtiV6IXZ4
	8z+J4GldGet+Sz7Ri3YyOxAcOTa5y7tf4pQNZynTFpeFQdVlnrJZah8oA/0kgKZG3cWElT2/S3RGe
	Rr2p3C3A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRykl-0000000BWdO-3FgH;
	Thu, 11 Jul 2024 18:42:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6A81E30050D; Thu, 11 Jul 2024 20:42:51 +0200 (CEST)
Date: Thu, 11 Jul 2024 20:42:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, jolsa@kernel.org, clm@meta.com,
	paulmck@kernel.org
Subject: Re: [PATCH v2 10/11] perf/uprobe: Convert single-step and uretprobe
 to SRCU
Message-ID: <20240711184251.GD27299@noisy.programming.kicks-ass.net>
References: <20240711110235.098009979@infradead.org>
 <20240711110401.311168524@infradead.org>
 <20240711160652.GE16902@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711160652.GE16902@redhat.com>

On Thu, Jul 11, 2024 at 06:06:53PM +0200, Oleg Nesterov wrote:
> I'll try to actually apply the whole series and read the code tomorrow.
> Right now I can't understand this change... Just one question for now.
> 
> On 07/11, Peter Zijlstra wrote:
> >
> > @@ -1956,11 +1960,13 @@ static void prepare_uretprobe(struct upr
> >  			 * attack from user-space.
> >  			 */
> >  			uprobe_warn(current, "handle tail call");
> > -			goto err_uprobe;
> > +			goto err_mem;
> >  		}
> >  		orig_ret_vaddr = utask->return_instances->orig_ret_vaddr;
> >  	}
> >
> > +	ri->srcu_idx = __srcu_read_lock(&uretprobes_srcu);
> > +	ri->uprobe = uprobe;
> 
> It seems that, if we race with _unregister, this __srcu_read_lock()
> can happen after call_srcu(uprobes_srcu, uprobe, uprobe_free_stage1)
> was already called...
> 
> In this case read_lock "has no effect" in that uprobe_free_stage1()
> can run before free_ret_instance() does srcu_read_unlock(ri->srcu_idx).
> 
> Perhaps it is fine, uprobe_free_stage1() does another call_srcu(),
> but somehow I got lost.
> 
> Could you re-check this logic? Most probably I missed something, but still...


  handle_swbp()
    guard(srcu)(&uprobes_srcu);
    handle_chain();
      prepare_uretprobe()
        __srcu_read_lock(&uretprobe_srcu);


vs

  uprobe_free_stage2
    kfree(uprobe)

  uprobe_free_stage1
    call_srcu(&uretprobe_srcu, &uprobe->rcu, uprobe_free_stage2);

  put_uprobe()
    if (refcount_dec_and_test)
      call_srcu(&uprobes_srcu, &uprobe->rcu, uprobe_free_stage1);
  

So my thinking was since we take uretprobe_srcu *inside* uprobe_srcu,
this reference must be visible before we execute stage1, and as such
stage2 cannot complete prematurely.

