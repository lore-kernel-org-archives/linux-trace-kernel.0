Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Hihgs8m2"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF029A
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8KvERjRQqiKIU2aozT18Qav8ul+lZde50rCvSyjwtek=; b=Hihgs8m2gRe3YqPtkP4UV6i4zD
	idJQaOTXNDkBg7qgQFrjf8yGfv8yRBWIjg0u1kAMKJeT52nDJ4atWT66uw6p5gyl8Fxw+2HlLzpVX
	52BIzC3hUX6nwUAtSj3DdDlpXHxPsZqF7rBdjSLh8dPYsVhRWiFU2H06PFXeTXeaP7+VPkrheSW8C
	j+d3Vq5+Fxc2xAIKkrCX7oXUpLxvfIrnHz4v/OyV59HHXtfx9mafF/km6o2b3DYaeBHVsmo4m7Y5u
	AlO+oCXXJQ5n2wB5UdWZwTSw7JmUtwNg6HV06aWNNDWoY9/WKYqiFTeHVlPuENUEO18YVMa6/7+2B
	PO0px6zw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40058)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r98AA-0003Qx-2q;
	Fri, 01 Dec 2023 18:22:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r98AA-0006F7-GW; Fri, 01 Dec 2023 18:22:54 +0000
Date: Fri, 1 Dec 2023 18:22:54 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Justin Chen <justin.chen@broadcom.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, mark.rutland@arm.com,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <doug.berger@broadcom.com>
Subject: Re: ARM Ftrace Function Graph Fails With UNWINDER_FRAME_POINTER
Message-ID: <ZWokflhL8cG7JiCN@shell.armlinux.org.uk>
References: <d870c149-4363-43de-b0ea-7125dec5608e@broadcom.com>
 <CAMj1kXGST7uH530hB0i-rzisNesNrUGsJ5a5eC9805Udi5msrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGST7uH530hB0i-rzisNesNrUGsJ5a5eC9805Udi5msrQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Dec 01, 2023 at 10:12:48AM +0100, Ard Biesheuvel wrote:
> It appears the sub instruction at 0x6dd0 correctly accounts for the
> extra 8 bytes, so the frame pointer is valid. So it is our assumption
> that there are no gaps between the stack frames is invalid.
> 
> Could you try the following change please?
> 
> --- a/arch/arm/kernel/ftrace.c
> +++ b/arch/arm/kernel/ftrace.c
> @@ -235,8 +235,12 @@
>                 return;
> 
>         if (IS_ENABLED(CONFIG_UNWINDER_FRAME_POINTER)) {
> -               /* FP points one word below parent's top of stack */
> -               frame_pointer += 4;
> +               /*
> +                * The top of stack of the parent is recorded in the stack
> +                * frame at offset [fp, #-8].
> +                */
> +               get_kernel_nofault(frame_pointer,
> +                                  (unsigned long *)(frame_pointer - 8));

Yes, this will get the value of the stack pointer when the function
was entered - which may be the bottom of the parent function's stack
_or_ the start of non-register arguments to this function. So your
replacement has always been more correct.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
