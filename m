Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795132457;
	b=enJipWTh9CbwTRjtXkLUPIqgQtywyff4zYOZLSIvFelcXRpyhtCHkDiREjEGTjYIqGXL
	 Y60PgW2L3VwnOIGaIqVp9fIB+kvdPODuORAJc0RX8iJxnKZMwU91HanFLXUw7dUWJQ8Nt
	 6t6MaD9cHRujilg4EV1rylSA/4WYzC1o9u2Q5FNaE3yGN21rfTk5g8f+Dx3DsW71TOpuU
	 SH71q/7JPvimtkNt4OOnfTesUJSxymeMC8YONhtY2rDaIckfsOSUFfsdhnozJYJYsF4Ng
	 CK9JinzPY/txusJxRLbrewir1Lm/nSIOohrpfp1hRP3tXJvo3GtQazs9f4kQVwWxsdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795132457;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=o8Jkl3D6PyKBQ9flRwdsQA2PhUfjW1xzSb0OsieXFqU=;
	b=kXMVLvlTlUKkX+btfnkSzEEfuGOVecwV64sVUG0i+FMFKscU5eF9dMfPaQQEFSUHi3K/
	 xIT20VaTXngcfxWcGfVnvsTTIzNJk1TMa2macjVTCy3YQGBXatzUJXJjPL3SZ1GOJBBgq
	 bQgHhY6Yoq5slSH/mM3tVJMHo52Juw3PoQPMvAwn5krlxLyFsGnm7NMZ6vQz35Qm1Kyb2
	 XORKoBOBCFCyxV+Elk4R4oehiCTMY6w73bbFNmOi0/BsMM30gl+AdGk8rZQWUpSnwGewu
	 n88iO/j3zM9rsfC5DyraEISoChxVDyDKgG263UhWl6W317cxo0qLjGt8k9yl6BAo/KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q70IX0lu;
	arc=none smtp.remote-ip=95.215.58.174
Received: from mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F11606A32C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 23:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76F11606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q70IX0lu
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SVZrlJks8sXPVt3xrpYdTAoVZmdk9CSrl7P148bcFmU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795132454; v=1; x=1795737254;
 b=q70IX0luUcbU6FCiJYBpmUfdNrXaCDzDyverVa5nohERhVo++3RcTQWOyKaGqDjVgz3oc5Fx
 VBY96WxGxsdaNk3gHTfIfp6AF/YK/SO2tPRF0sI/OQFkm0I4B33qwJ5F3URCKw0ij+tnYR3yJa0
 Gw0mzX4e9eiXeXHZeFdigyFI=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id eca0a2cac3c52e86;
	Thu, 19 Nov 2026 23:54:14 +0000
X-Mizu-Trace-ID: eca0a2cac3c52e86
X-Migadu-Flow: FLOW_OUT
Message-ID: <1ea66d73-4d40-4d95-855f-4235cbd1d809@linux.dev>
Date: Fri, 20 Nov 2026 07:53:53 +0800
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, akpm@linux-foundation.org, dgilbert@interlog.com,
 mkp@kernel.org, loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com,
 vivek.kasireddy@intel.com, jasowangio@gmail.com, eperezma@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, rostedt@goodmis.org,
 vdonnefort@google.com, mhiramat@kernel.org, jgg@ziepe.ca,
 kevin.tian@intel.com, axboe@kernel.dk, linux-mm@kvack.org,
 James.Bottomley@hansenpartnership.com, sumit.semwal@linaro.org,
 christian.koenig@amd.com, phasta@kernel.org, joro@8bytes.org,
 will@kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 iommu@lists.linux.dev, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, bobbyeshleman@meta.com,
 mathieu.desnoyers@efficios.com, robin.murphy@arm.com, mason@kernel.org,
 aesteve@redhat.com, tjmercier@google.com, harry@kernel.org, vbabka@suse.cz,
 cuitao@kylinos.cn
Subject: Re: [PATCH 3/7] vhost: account the per-device kernel allocations to
 memcg
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-4-cui.tao@linux.dev>
 <20261119101239-mutt-send-email-mst@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20261119101239-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, Michael,

在 2026/11/19 23:12, Michael S. Tsirkin 写道:
> On Fri, Nov 06, 2026 at 09:18:25PM +0800, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> Everything except the worker struct is allocated with plain GFP_KERNEL:
>> the per-vq iovec and log arrays at VHOST_SET_OWNER, the memory table at
>> VHOST_SET_MEM_TABLE whose size follows the user supplied region count,
>> the pending message nodes, and the vhost_net/vhost_vsock device structs
>> with their fallback to vmalloc.  The worker has been accounted since the
>> vhost_task conversion.
>>
>> A container that can open /dev/vhost-net or /dev/vhost-vsock, which
>> device plugins hand out with passthrough, holds roughly 150KB of
>> resident kernel memory per device after SET_OWNER.  Charge the rest the
>> same way the worker already is.
>>
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> 
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> should each patch be merged individually?
> 
Yes, I think merging them individually is the cleaner path here: the series spans six subsystems, and each maintainer taking their own piece keeps things simple. Jason has already taken patch 5 into iommufd.  Please feel free to take patch 3 through your tree.

Thanks,
Tao
> 
>> ---
>>  drivers/vhost/net.c   | 14 ++++++++------
>>  drivers/vhost/vhost.c | 16 ++++++++++------
>>  drivers/vhost/vsock.c |  5 +++--
>>  3 files changed, 21 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>> index 4570a4ffbab2..bab6597c696d 100644
>> --- a/drivers/vhost/net.c
>> +++ b/drivers/vhost/net.c
>> @@ -249,7 +249,7 @@ vhost_net_ubuf_alloc(struct vhost_virtqueue *vq, bool zcopy)
>>  	/* No zero copy backend? Nothing to count. */
>>  	if (!zcopy)
>>  		return NULL;
>> -	ubufs = kmalloc_obj(*ubufs);
>> +	ubufs = kmalloc_obj(*ubufs, GFP_KERNEL_ACCOUNT);
>>  	if (!ubufs)
>>  		return ERR_PTR(-ENOMEM);
>>  	atomic_set(&ubufs->refcount, 1);
>> @@ -302,7 +302,8 @@ static int vhost_net_set_ubuf_info(struct vhost_net *n)
>>  		if (!zcopy)
>>  			continue;
>>  		n->vqs[i].ubuf_info =
>> -			kmalloc_objs(*n->vqs[i].ubuf_info, UIO_MAXIOV);
>> +			kmalloc_objs(*n->vqs[i].ubuf_info, UIO_MAXIOV,
>> +				     GFP_KERNEL_ACCOUNT);
>>  		if  (!n->vqs[i].ubuf_info)
>>  			goto err;
>>  	}
>> @@ -1344,17 +1345,18 @@ static int vhost_net_open(struct inode *inode, struct file *f)
>>  	struct xdp_buff *xdp;
>>  	int i;
>>  
>> -	n = kvmalloc_obj(*n, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
>> +	n = kvmalloc_obj(*n, GFP_KERNEL | __GFP_RETRY_MAYFAIL |
>> +			 __GFP_ACCOUNT);
>>  	if (!n)
>>  		return -ENOMEM;
>> -	vqs = kmalloc_objs(*vqs, VHOST_NET_VQ_MAX);
>> +	vqs = kmalloc_objs(*vqs, VHOST_NET_VQ_MAX, GFP_KERNEL_ACCOUNT);
>>  	if (!vqs) {
>>  		kvfree(n);
>>  		return -ENOMEM;
>>  	}
>>  
>>  	queue = kmalloc_array(VHOST_NET_BATCH, sizeof(void *),
>> -			      GFP_KERNEL);
>> +			      GFP_KERNEL_ACCOUNT);
>>  	if (!queue) {
>>  		kfree(vqs);
>>  		kvfree(n);
>> @@ -1362,7 +1364,7 @@ static int vhost_net_open(struct inode *inode, struct file *f)
>>  	}
>>  	n->vqs[VHOST_NET_VQ_RX].rxq.queue = queue;
>>  
>> -	xdp = kmalloc_objs(*xdp, VHOST_NET_BATCH);
>> +	xdp = kmalloc_objs(*xdp, VHOST_NET_BATCH, GFP_KERNEL_ACCOUNT);
>>  	if (!xdp) {
>>  		kfree(vqs);
>>  		kvfree(n);
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index ea127af58ada..d1274106ad5d 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -526,11 +526,14 @@ static long vhost_dev_alloc_iovecs(struct vhost_dev *dev)
>>  
>>  	for (i = 0; i < dev->nvqs; ++i) {
>>  		vq = dev->vqs[i];
>> -		vq->indirect = kmalloc_objs(*vq->indirect, UIO_MAXIOV);
>> -		vq->log = kmalloc_objs(*vq->log, dev->iov_limit);
>> -		vq->heads = kmalloc_objs(*vq->heads, dev->iov_limit);
>> +		vq->indirect = kmalloc_objs(*vq->indirect, UIO_MAXIOV,
>> +					    GFP_KERNEL_ACCOUNT);
>> +		vq->log = kmalloc_objs(*vq->log, dev->iov_limit,
>> +				       GFP_KERNEL_ACCOUNT);
>> +		vq->heads = kmalloc_objs(*vq->heads, dev->iov_limit,
>> +					 GFP_KERNEL_ACCOUNT);
>>  		vq->nheads = kmalloc_array(dev->iov_limit, sizeof(*vq->nheads),
>> -					   GFP_KERNEL);
>> +					   GFP_KERNEL_ACCOUNT);
>>  		if (!vq->indirect || !vq->log || !vq->heads || !vq->nheads)
>>  			goto err_nomem;
>>  	}
>> @@ -2053,7 +2056,8 @@ static long vhost_set_memory(struct vhost_dev *d, struct vhost_memory __user *m)
>>  		return -E2BIG;
>>  	if (max_iotlb_entries <= 0)
>>  		return -EINVAL;
>> -	newmem = kvzalloc_flex(*newmem, regions, mem.nregions);
>> +	newmem = kvzalloc_flex(*newmem, regions, mem.nregions,
>> +			       GFP_KERNEL_ACCOUNT);
>>  	if (!newmem)
>>  		return -ENOMEM;
>>  
>> @@ -3405,7 +3409,7 @@ EXPORT_SYMBOL_GPL(vhost_disable_notify);
>>  struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
>>  {
>>  	/* Make sure all padding within the structure is initialized. */
>> -	struct vhost_msg_node *node = kzalloc_obj(*node);
>> +	struct vhost_msg_node *node = kzalloc_obj(*node, GFP_KERNEL_ACCOUNT);
>>  	if (!node)
>>  		return NULL;
>>  
>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> index 0cb87971d749..600daeb05e7b 100644
>> --- a/drivers/vhost/vsock.c
>> +++ b/drivers/vhost/vsock.c
>> @@ -721,11 +721,12 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
>>  	/* This struct is large and allocation could fail, fall back to vmalloc
>>  	 * if there is no other way.
>>  	 */
>> -	vsock = kvmalloc_obj(*vsock, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
>> +	vsock = kvmalloc_obj(*vsock, GFP_KERNEL | __GFP_RETRY_MAYFAIL |
>> +			     __GFP_ACCOUNT);
>>  	if (!vsock)
>>  		return -ENOMEM;
>>  
>> -	vqs = kmalloc_objs(*vqs, ARRAY_SIZE(vsock->vqs));
>> +	vqs = kmalloc_objs(*vqs, ARRAY_SIZE(vsock->vqs), GFP_KERNEL_ACCOUNT);
>>  	if (!vqs) {
>>  		ret = -ENOMEM;
>>  		goto out;
>> -- 
>> 2.43.0
> 

