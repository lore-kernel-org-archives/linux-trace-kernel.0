Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1DE15E1F7;
	Thu, 16 May 2024 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881527; cv=none; b=hiLyFt8GvNTXe9oL1yFI8cmKzcqdjAZcPM9YzmlIFqq6E3X6efkwgKUnqL+zcUVYxmnYVUBu1OxqtlIZXXgVnd3BYvmf5o91FtCwKMuMkGngej3jVv4f3dki/aPMlMCyxqRhIEFE/CD5bfDcHen9ro7DBSFqWDorrmKfE59hXEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881527; c=relaxed/simple;
	bh=g6o3EwBKNsFLLeY+gE+r/nqycvOvQK858RQCuiiVY7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unpMp4bmBHVp+2+/WpETSqkhrWF8aIhb1AlpNIM1aBOcpIwCIHi4dHYWtEKv4qjs/Uurlf/mrd62mcMJqwTPIj9CLq+KRHUCVaj2Qal1XUI/KVbP3B0JEu5mg1tC2cvOoe5Ze5FzCIWuYeTA8xeSn7ZIziCpbGAuNyrmzlKiTVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=gDcG1d1f; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="gDcG1d1f"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 77A13838877;
	Thu, 16 May 2024 19:45:10 +0200 (CEST)
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id E01C52003DA;
	Thu, 16 May 2024 19:44:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DO00WEdXqFHQonuL0UPMB1TAl+thIt5qyy/212nRK3E=; b=gDcG1d1f2HM9W8Vm0kmbegGiSC
	RNCJjYIBM6ZELYTfX3ixHaQzM0c+wLgyJ/F29JC6Pzssr9cQ7aqRhE7RjhevQZdOkkxBcrK99Qs1m
	iEaTBoFdRKxumFArgvEHnlDceYXzfXictXGMi9DeX4Pc7hSenobNUfQb6H/OorahsUmE=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.96)
	(envelope-from <guillaume@morinfr.org>)
	id 1s7fA2-006Qht-1D;
	Thu, 16 May 2024 19:44:58 +0200
Date: Thu, 16 May 2024 19:44:58 +0200
From: Guillaume Morin <guillaume@morinfr.org>
To: David Hildenbrand <david@redhat.com>
Cc: oleg@redhat.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, muchun.song@linux.dev
Subject: Re: [RFC][PATCH] uprobe: support for private hugetlb mappings
Message-ID: <ZkZGGkxXNaF5JPQ5@bender.morinfr.org>
References: <8d5314ac-5afe-41d4-9d27-9512cd96d21c@redhat.com>
 <ZilvOi7ceSXmwkNq@bender.morinfr.org>
 <b1cf78f8-8480-4451-bbf8-78694ebd0438@redhat.com>
 <Zip0fEliGeL0qmID@bender.morinfr.org>
 <e84a82b8-b788-499c-be79-e6dcb64ac969@redhat.com>
 <Zirw0uINbP6GxFiK@bender.morinfr.org>
 <385d3516-95bb-4ff9-9d60-ac4e46104130@redhat.com>
 <ZiwGovSHiVCF7z6y@bender.morinfr.org>
 <8a7b9e65-b073-4132-9680-efc2b3af6af0@redhat.com>
 <ZjMPtrsrUi8-QJ0G@bender.morinfr.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjMPtrsrUi8-QJ0G@bender.morinfr.org>

On 02 May  5:59, Guillaume Morin wrote:
>
> On 30 Apr 21:25, David Hildenbrand wrote:
> > > I tried to get the hugepd stuff right but this was the first I heard
> > > about it :-) Afaict follow_huge_pmd and friends were already DTRT
> > 
> > I'll have to have a closer look at some details (the hugepd writability
> > check looks a bit odd), but it's mostly what I would have expected!
> 
> Ok in the meantime, here is the uprobe change on your current
> uprobes_cow trying to address the comments you made in your previous
> message. Some of them were not 100% clear to me, so it's a best effort
> patch :-) Again lightly tested

David, have you had a chance to take a look at both patches?

-- 
Guillaume Morin <guillaume@morinfr.org>
