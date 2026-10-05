Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C22489FAB
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Oct 2026 13:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206470; cv=none; b=TvtvUXVP1eJPsgKCz3H3sWIf6WFGZEb/iT8ZI/GIQ1wXG7VOJ5gvrXKIKQYTxeWNI/0jqV8cOplbC2b7gnwPmm1Vvczfm4K1rg62BaEC7NpVUbEHBUGd87Z3BJSQN2o+7Vh+7IOiFY8IJYQVx+9MJ4hsQI85JVCXHxr9Oecdqu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206470; c=relaxed/simple;
	bh=SippWX+xoSkF20XXjc5MLFhzuRKSu+Feuro+st5YeiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgo9tqkbd6HbIVZAV6+31fKMfE/u53VMUiG6vRnxf9ZF45aNr4rvoZHhJWYuZBhcerR6PeAGRZELm9OkvUz5Z/k9ota++sY+273vPc+Ht9EhcTBcwtDJo1fw7gmHBx2akPeGiTIOG0ce9FkJlDnju4JHMRL7fyri+dhtidKUx0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyvePpA+; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyvePpA+"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb470so302856966b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 Oct 2026 06:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791206449; x=1791811249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h5zNn+04D/ADxwDdeMfBIdi2B0cMu31zTvDOOv1nE7U=;
        b=CyvePpA+5myhEw/neft3Qi0/VUFTYG5o456QppG2/5G9A7H9FId3WTbBHx92BbDih3
         4LHwzEeHMw4bsVoy4ghXYLnVyzQmc3Pt0m3C+oZcTb6uwWl7nasYTcIjezFXsWeu9zER
         thV0rkZZZxmmS8fy2eaY0H5qWPUpLiRUvK55PN6+JGLkJRFj1bbf2KPTnHhId2DS9ugV
         7Wo5kWmTBYhH07RDCvxKlHV1nwfMQkiQc5yYc7bHd0t9oNlr5C9+UadIxvLO240oDVQd
         HkiESF/uf7xSIHadAe3DnCy04kNQTyE/I9pVuX/PyyqPVdDsTIGcq+XqQ3i07SASQUp+
         byWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791206449; x=1791811249;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h5zNn+04D/ADxwDdeMfBIdi2B0cMu31zTvDOOv1nE7U=;
        b=gPjxfl+xMVqTEhgP+LZfs+3MFZsYvF2z6OFrsRMPWqd5KMWFJcsqpM6pSXJztlXTRO
         K2+o+FUv5l0MARvWX26wEIgvlisNLIz5K68GPhYPxjWD4AKlkgiCrCp3SfnkuGSiG+l4
         CcuR80Nucfo6NaOWKpGo52dlifEsEB4Mhp+stlM9d1r1lLGuVGAAAlKxO3bT5rbZ1s06
         fJSXQ7wAT/PWBfpYSJZP7CvsHvouvQll3Mt926RCZpoZ9i0C8ldNxZTiiKWVgBUTb/mf
         oCFk+4BB3yACKvo2Y5G73cgG4sd3dli0vy6gya6GuBc1Qcy8EfUWUBU7QvlMkozjrrpL
         Lxuw==
X-Forwarded-Encrypted: i=1; AKwUvBxyQscIKOSn9VYKAwJ8h2etC6OcIUiN+hCVAH7py4G6MG4A2a0Aio0o5ZGZ876SrF68P+23jOlJ6Oa7lclDxrTH0oo=@vger.kernel.org
X-Gm-Message-State: AFuF++kbWmgPv/aItvCphQp5eG+XZqQcoEtVsgKn3P53obaGukoTOzXV
	hngnU2gMRLVgquBGmempwLcPrSnTarCfM0JPJE7DFJmbzdhhu0jMoChy
X-Gm-Gg: AYBFou1eQZSuUgu+iPZrIDG6KUKzW7Br3RGJlkOIBVcI+4kmQkrVMeRbFiIRnr3Nfbp
	1o/tnfTmcSJ5pBNo1O79omcPmFiAvYmtiq0prwgaY9X7y9G6oU7M2uoPqDmOrd+EhuLdr+S9HFh
	bZufDgU11TaTs6XhnLKtzIycRtN9SdKhcD5femZ59DiXMCkZWtMxrM3YHRuzVWi8X88UGU9wraT
	6zSXgsonCR9Scr2+j4hlgkjz6Ic1umGnwipVqZRfpfVhdA/2f+bOoHblmzIotoH9wjlGRtTuQ7a
	ocmVQ3R1YyJAtgrC0AqdOhw7J5I86bQfbOhHr/eB58iUxyV/xPrrP0vIg0RloIJegCbYgVD6a02
	MQCBf2nJlzst9W5p3undhd1xzBLQ2XbYvrex9bgX7WQ0q4IH6VS2I/sEB/2R5i0lcyh9htRGiaF
	NG06MbPXyZRQDTjqXbJhXj0wZyVT1LVEgMbwtwGPCAEUumBwiE/dXYi+TLxeE101OGKaVBM/oz8
	VWM4I+5apCFbOmZz358fxTwb3o6epnoRpWsN7fE8xCRaFKSDqCSLft/FjpBmmZ9Q6rT/mPmykw1
	o1aaiQJpsvnV006xPbV3f+B7BHiJo/ByDns=
X-Received: by 2002:a17:907:9614:b0:c25:8eb7:f388 with SMTP id a640c23a62f3a-c2e4ad13957mr911322366b.17.1791206448599;
        Mon, 05 Oct 2026 06:20:48 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3156333a04sm79392466b.60.2026.10.05.06.20.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2026 06:20:48 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex@shazbot.org>,
	Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [RFC PATCH 2/6] dma-buf: Add get_phys() to describe a physical run
Date: Mon,  5 Oct 2026 13:20:46 +0000
Message-ID: <20261005132046.30025-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <a04f17cc-f59a-4240-81c8-29776eee3a2e@amd.com>
References: <a04f17cc-f59a-4240-81c8-29776eee3a2e@amd.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/5/26 Christian König wrote:
> Well filling page tables by the importer is an absolutely clear NO-GO
> for the DMA-buf design, we have gotten down that path already and it
> took us years to remove this functionality again.

Understood, thanks for the quick and clear answers on this patch and on
patch 3.

> The problem you are facing here is that dma_buf_mmap() doesn't work
> because you don't have a VMA.

Right: the memory has no struct page and is deliberately not mapped in
the host, so there is no VMA to hand to KVM.

I'll post a new version of this series. It drops get_phys(), the ranged
invalidation and the guest_memfd dma-buf import (patches 2-5), and it
does not touch drivers/dma-buf, as you suggested in the PAL discussion:

  https://lore.kernel.org/all/c413710b-4c28-4ed8-88ec-aeb8c4482011@amd.com/

KVM gets its frames through the KVM-private guest_memfd provider
interface from David's series. iommufd gets them through a private
interface with the exporter, as it already does for vfio-pci. The new
version adds a small registry in iommufd for that, which replaces the
symbol_get() of the sample in David's series. The dma-buf is then only
the handle and the existing revoke.

Thanks,
Fred
