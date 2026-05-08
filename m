Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2C836404E
	for <linux-trace-kernel@vger.kernel.org>; Fri,  8 May 2026 23:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778283405; cv=pass; b=DWOSgyFK8JiikOZQSyc0QqNhU6QP5hlG2GrcVHqberv2gh0np2PMxBdznjXVi3ruc9JZNyNmAWuSEuwI8FFXrsl/D1ngwbDy/87+6Yx8AxAwEPfEZDICkRBJ+PGMHLt1GKbEnm771vqBxz2Wv+P6DeJsP5Ka0hfI93hST2YGhoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778283405; c=relaxed/simple;
	bh=qugc+0Ib7z8RHG2l2I3zLFMp2jsqIX/yclDbZ06fydk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9M8dSEGpap0ZNr9LVj0KiR7GOUXFvJwMuXC3xF0KFfDyti9BscFO2AaiZl+sPfsyFneTd/qCkGyBrdvmKKkyRSnJsFm0DaPNDECJODUaSQBNxb5ZsSLMSgXnBHjwlIxyyRHZe61gDe2nOYrJE1LUuMFa5AbyxyAFoCHJiqGJaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IFsr6bod; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFsr6bod"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-57512a429d1so1709564e0c.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 08 May 2026 16:36:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778283403; cv=none;
        d=google.com; s=arc-20240605;
        b=BCRws5izmRonXEUFCruKoxbGHhckMKvp+wz6F2ewdXJJIqbn8toV19rsKz2basG4rx
         HC6Tawd1cwfjD2TR22ZoAX2iUpuOxfyh0gBfxitqyvOP/m8tHE1Ya/wpxR0NVYDKHMDZ
         8bUbES4YOVtpSu353fv7es7BjcN2MXmBJYKaYvJ0CXfr2Gj4ERfU3KSnxpqFCkVcJud8
         R8CewUuk51VHnAHP6MoQByVCDAGJdStWln2VmV+ov3I0EUhLojZQMc6UYeOdiYTFrpr0
         3Rp3zmbH269J+22Ewk8m07GLkaw7ae3kiAeAg8g8nZyqVWtAp1U6LScfgMgzACNAGTg/
         W1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=10imNO/dPWbMThTpLIZ3BPvS8U4RD3Gbc9CIOJSztJQ=;
        fh=CV+U/gLFk56LlxlNJR/r+irctEEEOmAUI8mK2U6DLRs=;
        b=S2iIMi8VOXtU5OOauS902k8CcHP6OJzQB/bCniXnn7c83Cnz0SOotbqBCgiQbtWfpw
         7xzQ01sOAZQu+5kvAJ2YVBrYTKCms9Ltriwm2D5hB88HfDgvJ5OiHPx0uXgMUVBbX9rm
         jdqu1Z+XJOmHIrJTeS+jEulbVHPPGjCbijTASr5OB0GnEiJTsRCkghJ/C4UmFqZMMF5e
         LKGIrW49SNqQmpzC6MLB7/GfyDtb19uZYG1xzy3uMncPWEaDuNbalqNhm44X5AoZCjX4
         hTflk7n/dalL0Synw/E/zNv/J6SWOjUMymFIT+7Lkj1YZn+khyN9B+X3KoihdICavTYW
         NPMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778283403; x=1778888203; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=10imNO/dPWbMThTpLIZ3BPvS8U4RD3Gbc9CIOJSztJQ=;
        b=IFsr6bodQZG7r4hxx08grgPMBlY0KlF2AhrFstCEFeDAS1u8eCladLOLiJBmxZdoPV
         emGB896Sdz9ACDVNOJnEPye4LN+Un4O8PHiwXq5G36QxAM2yxBmX1nIymV2sQNH0umBZ
         vEvopJLSR7xna833MQcq7BAAVfmlPkjRHMfzO+uOlozGPYomDIg4ZDMNsJxS/RAPgBa5
         MN9H9/t8cKIlu1V65pSIYmOHXFGV7CMdbbTdOQaBmNF8b+ouXBQipcJeyNeelskJ3G6C
         WMpaAIprt38Xirk89Q1T1BkaRK8NrIQajrraKWcNAYq2rvG3ItZWTam+SLWVw0hpVmk6
         O00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778283403; x=1778888203;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10imNO/dPWbMThTpLIZ3BPvS8U4RD3Gbc9CIOJSztJQ=;
        b=JshCDHrxaixSs0niEG1nPT0ai2Nbf4CPU1MlHo+LrHAgU397G14rKQZWSL1E9hPEZf
         ct7HpFIQmKklnlB2YXT0Q69FzxQ3t+xhbjq9nwP8zGjO2cNvgZp1XUmxIV/NRbYjppHU
         nzcwTQqk8I0jZ0bN3QEdwIPPrhGGExdvsiWoV+QoKOY97A+eFw8/fIZL9gHt2Iq8O3eU
         ty5SEwI9bkIrc2NNRKbFws5NgOb8mBf74L39rD50ss91NenT6fJ3RICx75dibXUlHd09
         VV1VQaWoputSx7VZJqUwww5L6a/wtKMTLHx39GeeQHT+V9VCEp7tk6jbN5pDTgVEVR3N
         xXnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+4gqzMlm36WAXa/ufsG0rENZAIwL/UUogoSjuyXFDoP5FCmMZUc1y2CraHmx6faVt3HhfYvQzKxxU1CRVM2lSXSMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy90axs3CLZYLI+PZgS7ElwhQzL9d9gY1buUXiCovjETuTi97O5
	f5dVRjlAVR7bUETbQx5tPTGrNs+nw7/reqS/KRk2n31ctiuq8Oh5L9aYyF0YjygPMN3/De0YFN3
	qLV2eoe5MrmWG98A+G9wIeUjm68In9qG1tqec3n0H
X-Gm-Gg: Acq92OFv6GgywPqDGGIidF0KjKbEnA+IUGj+zYd2JZMQHDQre6qGM+soBuGQtUhha6X
	1MxHgQsjRddw/rbvg3p7sLsmKE6ZoIk6vvBsxy2IfeUv3uNV0ZWgzM0f0e9vJadOy8zDWnB6OF2
	ImEkJusWEdEB/JbpUB9Sg16q/Q/WJjaeUMcZEoy+Du3LOSrDQtApBJJwDSRz1dOGInmsq2Nl4Mu
	uSithQXrZxQjxh7JPktF0M2FPBDfC3aRfHpNS/yS4m8HkbwKawGDA24OXJeBDxzKr54NDDrcG/6
	uxP6RuKZMccWYKtvG2tO7nIbXNjBq/FPmwFuf/NOS5Talb5SF2gfGB2g0WO0x6z5dARFFKdikvA
	17JCEdgEDDlq0lt4=
X-Received: by 2002:a05:6122:3208:b0:56e:e80c:bb25 with SMTP id
 71dfb90a1353d-5755963576bmr9165277e0c.13.1778283402011; Fri, 08 May 2026
 16:36:42 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 May 2026 16:36:41 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 May 2026 16:36:41 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-1-91ab5a8b19a4@google.com>
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-1-91ab5a8b19a4@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 8 May 2026 16:36:41 -0700
X-Gm-Features: AVHnY4LvPjVICPzN5-_CJPHTIx7ocT885vUY-RO5A-DcMZDUx5r_5g4UegbM0fM
Message-ID: <CAEvNRgGF-n5gmTR5G7wZqH5gBZsOp6WMR-RSws+=g9tcCkfSiA@mail.gmail.com>
Subject: Re: [PATCH v6 01/43] KVM: guest_memfd: Introduce per-gmem attributes,
 use to guard user mappings
To: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, ira.weiny@intel.com, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
writes:

>
> [...snip...]
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 69c9d6d546b28..5011d38820d0d 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -4,6 +4,7 @@
>  #include <linux/falloc.h>
>  #include <linux/fs.h>
>  #include <linux/kvm_host.h>
> +#include <linux/maple_tree.h>
>  #include <linux/mempolicy.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/pagemap.h>
> @@ -33,6 +34,13 @@ struct gmem_inode {
>  	struct list_head gmem_file_list;
>
>  	u64 flags;
> +	/*
> +	 * Every index in this inode, whether memory is populated or
> +	 * not, is tracked in attributes. The entire range of indices,
> +	 * corresponding to the size of this inode, is represented in
> +	 * this maple tree.

Concretely, if the entire guest_memfd is 2M in size, indices [0, 511] is
represented with some value, either 0 (SHARED) or
KVM_MEMORY_ATTRIBUTE_PRIVATE. [512, ULONG_MAX] is also defined in the
tree, as NULL.

Since guest_memfd uses xa_mk_value(0) to store the value 0 ("SHARED"),
that makes 0 distinct from NULL, which works for guest_memfd.


(Liam and I discussed this off-list due to a email configuration issue)

> +	 */
> +	struct maple_tree attributes;
>  };
>
>
> [...snip...]
>
