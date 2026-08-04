Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52C643E9F9
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833462; cv=none; b=LyVXxFFissdVYXHjlS9nvJfDA933SIpt4JHRVC4V5pB1AqK2jzj3LgZrb3dJYEq9b9Bu3Ozj464r2o6sfUZLCV4+KbGrASPM6nUo1FMSy/Ja14d3ZiseKb9sTcMn0nde+EF2ZWCBngXyb7rDrtZ69GpokITlRQFZpVnyInyFVhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833462; c=relaxed/simple;
	bh=dizy8BMrb1EtFWw195sX+m69N2yVavalVSh186iyFhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpEqSRmRAumS3VoCmcgRtd3KY/XpM+FOhV5lbKTfeC+LlGpxiNQjuOJn1GSslKH2XyTBx6NH/jYu2DKvWM9FDwclO+ok3gsSey5hDn+V/Rb3UXVm4buhVO0XPzBIYO4c3PiBPI/KDNUenho5efaqgUc3vO4IDJZ4/dMsED0Pscw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hSOFZM+a; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hSOFZM+a"
X-Forwarded-Encrypted: i=1; AHgh+Rqfof2u0G4vhQiX+SLPDrChkp7RzEhjPJMzC4gJGcNQZlx8LO6Eb/5SFNhCPudXkBf7BBfkAMIpmHu4RF5XSwXMgZo=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785833458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LEo++tWNX66vRUCbHgrcE/DoABgbXtbHvpdUx5myUAQ=;
	b=hSOFZM+acbTltyXc1pxBtE6umoV4jaae7uInsCvRFzXnZBtYsvKpzY8e4lDUKcCyg86JGS
	hrB1EirqP1qnDTy6zZaKpmX//l3Hv45bwfEh/NunG3Fs5T1Nn93blfizgea4e+bf8zW5k6
	xsGBJURWLxCiCqeVroa6nFHeezapkuA=
X-Gm-Message-State: AOJu0Yyg0CqqTL6XriewHDqQzzBVIEpGu7Ryz8+PAJmZNJQ3BNTV8NIi
	V2SUhq/vs8CXYIvxbfCZNisLrzNV7+pOlWF45FWWGtn2snRCDl7dtLWUOtFuw1s2bG8SpMzE6mn
	gZJdpht0ovdVwmVhx2Zail1giI9LhUMN9iecTqVVW
X-Received: by 2002:a05:622a:1649:b0:528:38d6:71b4 with SMTP id
 d75a77b69052e-52cd5150f2cmr10989531cf.11.1785833444348; Tue, 04 Aug 2026
 01:50:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803124220.332248-1-fuad.tabba@linux.dev> <20260803124220.332248-11-fuad.tabba@linux.dev>
 <86qzkfaxp9.wl-maz@kernel.org> <CA+EHjTw1=xCPugZrmQ3nj1ddvCZ=vcZT3=KO_FMHB1USUTu7kA@mail.gmail.com>
 <86pkzyb7bn.wl-maz@kernel.org>
In-Reply-To: <86pkzyb7bn.wl-maz@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 4 Aug 2026 09:50:07 +0100
X-Gmail-Original-Message-ID: <CA+EHjTyY+8-Cv1=dHg=4fbmOjtvA6+aY4yqV5uY2ev=uGJHEKQ@mail.gmail.com>
X-Gm-Features: AUfX_mxuF3k7WlOHdukcbNyPC8gFg_R9mHxire5WFqvzPcz3vuSQrFTruIYyFdQ
Message-ID: <CA+EHjTyY+8-Cv1=dHg=4fbmOjtvA6+aY4yqV5uY2ev=uGJHEKQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] KVM: arm64: nVHE: Check hypercall handlers
 against the declared ABI
To: Marc Zyngier <maz@kernel.org>
Cc: oupton@kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, catalin.marinas@arm.com, will@kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, alexandru.elisei@arm.com, 
	vdonnefort@google.com, joey.gouly@arm.com, seiden@linux.ibm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, qperret@google.com, 
	ardb@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

Hi Marc,

On Tue, 4 Aug 2026 at 09:47, Marc Zyngier <maz@kernel.org> wrote:
> > I'm happy to respin with both of these, or would you like to fold them in?
>
> Oliver is in charge of 7.3, so I'll let him reply on this.

I'll respin in that case, make life easier for Oliver, since he
doesn't have them applied and they do conflict slightly with patch 11.

Cheers,
/fuad

> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
