Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37CE22A1C2
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Dec 2024 17:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734715662; cv=none; b=aOCykpsf3pTZR5j/6mGTK0vGvSb9jmzSgsdpxwK1ldxOoAEuoG1GYHYyedeg7HRLpLP+ivKtrZ0yvoynojmsuxK2mKVVP1QR2G+YB0KDYMEDdKvSUC5u0ISg/WRFuKrRN22Zq1FARLSEe/IE8EyO+gBW650ynPLLLmsE6pVmMoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734715662; c=relaxed/simple;
	bh=ftFlFL8Hf6gjCPdcRFrVx2YclVhyvU0X+h6fy2EfzIQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UQNi0igPsXwM9qFnnts2dgxnSTwO895Kv9hBT0k9jb188JulY7HsTRvSl4q40QWY22n1qAL1+oKs5nVI9Q3O/tNo42c1MSG0BwHOWRHBBeG+yTvqORK5lai/Pm/d/J3Xx1A+1AkFVpyoDT++dKi8sLJR136v3Q5GGrvStnz2W4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sux4smDW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sux4smDW"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so1519566f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Dec 2024 09:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734715658; x=1735320458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rl2GUGW1SKIB73yuGvAyVPoBfBy5XbBiVj4hV5yN+VI=;
        b=Sux4smDWvhRYVAocCLrB8sH5Gn4iglVnvLOtYXjw2SwmbrW98B6c98IdTir+VF+VQJ
         W10BWI4R3GFC1zT/iJoBlxuzYK0hnggsfABamHJxaKShxH8tLAyw6SYs1kiT5Zpq5DY/
         y8F5G+SxDNISHMSnfr/J8ZC+W2oNrTFwJ0KMsYltX1nRmRejzvK8hykx9rw4E4PSCPjK
         hBR+wlIXLMxbiloh7lXnf5z8TBJg0j3ePqZ9LWqb7cYYzpaMr36BzlgWIDpW6dDQHpe5
         znRcS8BpCe/go3BIeiuQzZZSpEoYEyOJCj8IeINw++6FJJgIOUIPFK+PvAzsigdqsUly
         aZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734715658; x=1735320458;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rl2GUGW1SKIB73yuGvAyVPoBfBy5XbBiVj4hV5yN+VI=;
        b=s/3lYcjPFzspGk0WIG2Me9vphpUfgnJy+yuI6wa9wxh0yCl2AH0OrxCutxPXgGh2iz
         ltJsJtVjLQLZD85B4Sgi74vrhQleJYOiwPVV6Fk+gCB0hw6cKCA+UUA+ULyG3x9nyKf/
         dtJ9jYk8/44JpYPoCg9XCVGXmAB4QAD8k/+iKZxDX+Hc/+U+kvdahkqyoAmorm3J9uif
         4sfFzqy2etyFf1zBz90Idy06xZNzoiYdALpF+2N8cVpSpDR2W+eAp984SbR4ua2FU/Ab
         frgC5cRj1JAjVZR0bPTKRXRcxyAGGNv38miE87ZZGnnaAABhDv9AtJnZC+3X8PAklnO7
         7CPg==
X-Forwarded-Encrypted: i=1; AJvYcCUbsOK+6EHKQUBfVCOckcsDYfKPGct5VRj3iTgEUCab/6VV9XlH1cUjeJAlgZsQSp1HblAXCmq0soMS6xtfHo+S8KM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQfc8hTBx+zyhG1LTXP442TaOK63Bcfgw4tvbXpznTCNFaE3q6
	cn6Q63ke0yif6L+fpdQsZ34by2Di9slX1s1XhSR3OTWlnNIFS1MuTUEfqC0bQHk=
X-Gm-Gg: ASbGnctAOpkmFt6iAwtMCkkQg4k2gq7ooAvoE0bhtoDVrjgpUeA3wpp0S6uYlGqF9u/
	GXlDtxn+9xTAEd8aQSQdhkNWr7OjuIAUwkMFt+va1Ryz9kC1KNAedtYNg+wRGPUsMfaTLYGD9fC
	lBP4GlBR0dkG+9VV+bnUNE3utNUz5j01hHhiuVhdId4kds0q+MgKBgAOa3kCzmrty4/O8GzHadO
	1toVsDlmGzgvmZQP94IQbO74rG6lFVZB9soVzAElARMAhx1vNtAZS/uLpZktSo3CiRxNYWbFqM=
X-Google-Smtp-Source: AGHT+IHQofl14bIpVpiQqz6qAEwAjKsEmWVjRCOjis6wH9jKfvKMjWLHCbYlsDgmYPDOjR7ci+Y7xw==
X-Received: by 2002:a5d:47c3:0:b0:388:cacf:24b0 with SMTP id ffacd0b85a97d-38a1a1f7253mr6745803f8f.2.1734715658179;
        Fri, 20 Dec 2024 09:27:38 -0800 (PST)
Received: from [192.168.68.114] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e357sm4642915f8f.72.2024.12.20.09.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 09:27:37 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: linux-gpio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, audit@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Zhihao Cheng <chengzhihao1@huawei.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-usb@vger.kernel.org, linux-mm@kvack.org, 
 maple-tree@lists.infradead.org, alsa-devel@alsa-project.org, 
 Sanyog Kale <sanyog.r.kale@intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, dccp@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
 drbd-dev@lists.linbit.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 nvdimm@lists.linux.dev, linux-leds@vger.kernel.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 linuxppc-dev@lists.ozlabs.org, tipc-discussion@lists.sourceforge.net, 
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 linux-trace-kernel@vger.kernel.org, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, linux-wireless@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Subject: Re: (subset) [PATCH 00/35] Reorganize kerneldoc parameter names
Message-Id: <173471565665.227782.7244101246430956449.b4-ty@linaro.org>
Date: Fri, 20 Dec 2024 17:27:36 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Mon, 30 Sep 2024 13:20:46 +0200, Julia Lawall wrote:
> Reorganize kerneldoc parameter names to match the parameter
> order in the function header.
> 
> The misordered cases were identified using the following
> Coccinelle semantic patch:
> 
> // <smpl>
> @initialize:ocaml@
> @@
> 
> [...]

Applied, thanks!

[31/35] slimbus: messaging: Reorganize kerneldoc parameter names
        commit: 52d3d7f7a77ee9afc6a846b415790e13e1434847

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

