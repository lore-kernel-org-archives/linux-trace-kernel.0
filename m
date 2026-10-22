Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699240;
	b=NE/1Q6/cbnDk6eFGHqxuRiygKoIkFruc+dh2JRU84jlW4Daw3W2ZVrBB6URYvOPx0s7t
	 R/QjRxjIZQ0BLVSDBWrQ/Pc+zPmkH7d1lgOUOdCZTEqsfDQpznPJpjUnUNx6tDlW8cymj
	 BzZFOzg3qxiJvk8Ud1b8X7IhQzPit2QWXP02icd7QwMYSK8sW/LxCdArV0IPDEJW6avfD
	 dISGltigixd2JBvI+OcERBZb7PjzI7oE6hPIuLsqVV66Vf7v6MHUv+0o80L1xiRtwdVm7
	 D9o0iMNaPrtuRdy2gx+Rb9AmEeL+GWfodA3+JNMVEqhHDqqRbcwyDAIl7YXE8OgctKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699240;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=2netZtz4Kj0wMujiC7ldS8qx5V3GT+iMRLxNo3bLj/c=;
	b=DpWTUXUEB42CjLs46hiRSEdLRPtGYk6XTNXowZJVRCEtjl8oF6O22R4d4tEhHbKB/HEb
	 gEhlgRGHtLJoiEAhoPFsO8oFo7Glw33HmhAmAMPCjN+PjAm/TEVTtFF2zHdacMzMLs3eB
	 Q5ezz9zg/h0xiNPPPTeBoJcPrCRqmLMG4dz20spooLjXbU4+Ew2whPnUAcNDrVzPJVPel
	 9/ICfWC28D8UF1loUVrV0sFk35a+IWsYY2mhk8lDxMZPsaivoH/Gob0/Cz/MmM9Wp/zRt
	 jMkiZPH4DimZh+lMJM4UxB5JhTASIxywQ1dAOxLRfu2/y6VDGB4zgTgTUsiEJQ9xa+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=q68wAdqz;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92703606A31A;
	Thu, 22 Oct 2026 20:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92703606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=q68wAdqz
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 8FCCB1C1E2F;
	Thu, 22 Oct 2026 20:00:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 658886000E;
	Thu, 22 Oct 2026 20:00:35 +0000 (UTC)
Date: Thu, 22 Oct 2026 16:00:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, "Mario
 Limonciello (AMD)" <superm1@kernel.org>, Eiichi Tsukata
 <eiichi.tsukata@nutanix.com>, Julia Lawall <Julia.Lawall@inria.fr>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpuidle: haltpoll: Only define guest_halt_poll_ns
 tracepoint when used
Message-ID: <20261022160034.701ae74d@gandalf.local.home>
In-Reply-To: <ae46d1e7-6e49-405c-b4ba-9f659f5fdab3@intel.com>
References: <20261022153359.2433474b@gandalf.local.home>
	<ae46d1e7-6e49-405c-b4ba-9f659f5fdab3@intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 658886000E
X-Stat-Signature: z13oubcnwnwyzrifkym18ja5g7agof4x
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18I45iPFD4Ur1ZyF9bhKRse9iLI3R25q/s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=2netZtz4Kj0wMujiC7ldS8qx5V3GT+iMRLxNo3bLj/c=; b=q68wAdqzU7C/mEoofHGAvuTjC/hCkS2+BdTBA6Flv6Kic6oP5Gy9DXAs1AlgLEvz7Pl0qcaqDsQSYQCR73COQKZLXvz5Qqju1iUvUrNBDk6eKZI0fgvOYG/OfZKjCJJGEPOHZ1PRqePqtVDCJVbGcNH7RdOmHKdTb0IsxTpufOQ=
X-HE-Tag: 1792699235-498473
X-HE-Meta: U2FsdGVkX1/u5LDf6egGTlGCuo7G7/Uyo8IbG17/AVS/mucPxWsOxIHbvLs2OpiGxp4p94gmfdx1yxZdaDkCgxyqsjVhbsa8snv7WDXIWFheeIjYC++xsBpRxzgvrtrVQVLPPpGkkPkd5RhxhVIUyTA1uZp31FVQVbxiI5rwG10He2hoWTpiTF7C0GysrIQ47dbwUR8vEXneesrRzXmI6fwAJsw7ewLkalPzBhwkqFrgpv0FA8RJT51g1FemT2u3a3MQsxNDFVxJk632Z9k3MpmMOwObttw6Ef2mJUT3aVVHdH+2+HevL4RCXDw47vqd65kLxtcEf8wMo7YbMTy88xsrF7TWsIh2bpafc61lmezU5eRIRdO2yj9ZtFKRW2PRjk/JY68xTunNOVZIp42RTg==

On Thu, 22 Oct 2026 21:54:09 +0200
"Wysocki, Rafael J" <rafael.j.wysocki@intel.com> wrote:

> On 10/22/2026 9:33 PM, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> >
> > Tracepoints that are defined take up around 5K each, even if they are not
> > used. When a tracepoint is used only in code when a specific config is
> > enabled, their definition must also be only defined when the same config
> > is enabled otherwise it wastes memory.
> >
> > The tracepoint guest_halt_poll_ns is only used when CONFIG_CPU_IDLE_GOV_HALTPOLL
> > is enabled. Guard the definition of that tracepoint with the same config.
> >
> > Fixes: 0da11bf0cab90 ("cpuidle: haltpoll: Add trace points for guest_halt_poll_ns grow/shrink")
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>  
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Thanks!

Want me to take this through my tree, or do you want to take it?

-- Steve
