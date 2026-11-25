Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795571581;
	b=qe3EvBceGbHEgwfeCqag8LIbbHgXBd/Q7eRo1oouZZ71dg6kGXHi6CTLBjo0EH5rCEcf
	 KsUm3OXtyPEU/lKUMLN+8EXYICO3V+h0FlbOTdXIwfL8t+d69nrwzc3rJW2XagvXumg2E
	 B6xv2yFRSvTPztzUWhEx0uy2cNFYOxBD6S3yo0smXlWY8Qf5BkkbQIiB9wdDyeeUV6IEf
	 Dx+0/2bsfivyc3mkiTpoeKeyMI0J8AK8fqNZhklpMnYNZTu7OmNJxbzSOAZKEtZiXhvdg
	 EDQ7Ji3KWwNYIihXrU0kHtPi3M/D3RkZGs2OqlLM7+adYac9q3ThtMRMKL8UWHqceDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795571581;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jaB4Mv+DeHP707ym9LoSYNoP970bEwCRqi7G6jSOMUo=;
	b=RqO7LCUVUincgVmfVvo60NuvxAsJaXHgHFZ5D4nqJiQkWYFRI/V37f9TxxcHzW6uZosV
	 hVF02LgnVU2aHb9GWGetSK3n2CQMElzMHEpxUK1ib9euAiZFeiAmFch2zLM9+RqwnBH2N
	 JrzfvYy6HP+Im4qnlnpLYosgjI8x39hLDZf6HNeu0ih2k5/CULKATLQlf3/Ed0xDJBDHN
	 UY0KRlNkY5pDdeCdhTR9XYZaRTSAReXRd8/7Cq8nAKT+AE++a0Madod7rJUPL1Gv7YHj5
	 NYtGtukVfzduA8MQ+fEvxYz6qUoQdvuAWzohNRlBsGJ6M768/TKlqb0S/vdglY+XBLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cNFRDVtL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F43606A321
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 01:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cNFRDVtL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169B91F000C4;
	Wed, 25 Nov 2026 01:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795571581;
	bh=jaB4Mv+DeHP707ym9LoSYNoP970bEwCRqi7G6jSOMUo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cNFRDVtLYWxS5t4fx9WuQyIJ+F4E0lVtVjnfb+hSX4DsXENl8AA0dNmipPv8CIhC/
	 QiRvhwm/GVTiAoCrkZwRQF6mVitNeM+qnqCqBLzVtbcIvu58Iqy7Dq/FxlZTz8ct7r
	 JjbjY/EvIgLHhWuMZ+xt0x502nwLwLHTO8StSlgmlV6wB8VZkstZDIUJnp4fBmoqp5
	 CeeVl4c5lISokYIDOWWQII9geZTuBUPJnlBymtiqRjzv0u5G2+YDae4NMBoWVP2ywx
	 HGQv7/NT5mvyLvtJbIShA3aPYOZOP4Bv2iLxx7U8xMTL0NHCTLxPmwFaZU8Y6gA8tA
	 jAiUxhKO0+9qQ==
Message-ID: <sashiko-outbox-232360@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] iommu: Trace I/O page fault response latency
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhang Yuwei" <zhangyuwei20@huawei.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261125013430.2144822-1-zhangyuwei20@huawei.com>
References: <20261125013430.2144822-1-zhangyuwei20@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 01:53:00 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] docs: iommu: fix short title underline in
  Documentation/trace/iommu-iopf.rst
- [Low] iommu: missing iopf_trace_response() call in
  iopf_queue_remove_device()
--

commit 98dd7f9efb7c0639fc5bdb2729afb3491dcaf701
Author: Chen Jun <chenjun102@huawei.com>

iommu: Trace I/O page fault response latency

This commit adds the iommu:iopf_latency tracepoint to measure software
I/O page fault response latency from iommu_report_device_fault() until the
driver's page_response() callback returns, along with tracefs
documentation.

[ ... ]

> diff --git a/Documentation/trace/iommu-iopf.rst b/Documentation/trace/iom=
mu-iopf.rst
> new file mode 100644
> index 0000000000000..259cf23c68992
> --- /dev/null
> +++ b/Documentation/trace/iommu-iopf.rst
> @@ -0,0 +1,52 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +IOMMU I/O page fault response latency
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[Severity: Low]
The title underline is 36 "=3D" characters for a 37-character heading, which
causes Sphinx to emit a "Title underline too short" warning during
htmldocs builds.

[ ... ]

> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
> index c16ff1fc4b95b..72e654ea5ffe9 100644
> --- a/drivers/iommu/io-pgfault.c
> +++ b/drivers/iommu/io-pgfault.c

[ ... ]

> @@ -334,6 +350,7 @@ void iopf_group_response(struct iopf_group *group,
> =20
>  	mutex_lock(&fault_param->lock);
>  	ops->page_response(dev, &group->last_fault, &resp);
> +	iopf_trace_response(dev, iopf, &resp);
>  	list_del_init(&group->pending_node);
>  	mutex_unlock(&fault_param->lock);
>  }

[Severity: Low]
Should iopf_queue_remove_device() also call iopf_trace_response() after
ops->page_response()?

drivers/iommu/io-pgfault.c:iopf_queue_remove_device() {
    ...
	list_for_each_entry_safe(group, temp, &fault_param->faults, pending_node) {
		struct iopf_fault *iopf =3D &group->last_fault;
		struct iommu_page_response resp =3D {
			.pasid =3D iopf->fault.prm.pasid,
			.grpid =3D iopf->fault.prm.grpid,
			.code =3D IOMMU_PAGE_RESP_INVALID
		};

		ops->page_response(dev, iopf, &resp);
		list_del_init(&group->pending_node);
		iopf_free_group(group);
	}
    ...
}

When a device is removed from an IOPF queue while fault groups are still
pending on fault_param->faults (which already had
group->last_fault.report_time_ns populated by iopf_group_alloc()), those
groups are completed with IOMMU_PAGE_RESP_INVALID via ops->page_response()
without emitting the iopf_latency event.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125013430.2144=
822-1-zhangyuwei20@huawei.com?part=3D1
