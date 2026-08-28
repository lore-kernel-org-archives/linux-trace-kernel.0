Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5261839A04A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787905484; cv=none; b=V0uT3GnejzonENE3LMk601koG+62c0dpgR5HDRTictYI8NtDn8FWt8j/GXnel2D8VBGpYpUpRdb8W/Bf0/pAvKmKAHyuS02zIuYZjmNWVLAJgJpzf+m8y9wNdN42j0TgFK4QtLhhhtRJ5VrYFbeXnoxzza+tg/T6wtCAVTFrcpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787905484; c=relaxed/simple;
	bh=1O5Q9iW7lI4chjQDzpIGp7IIC7IqqwCpT7ZNZFUg+n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJuvveVPPimZnAgKrQaMpuFa6OJNneyqRr5vdv1+Y4FDCpWthZqp7t2xgIBRDHfpmpUTeyBEC1xOo6qNDGDbUINzoE61xWnNl8dI0j+i7wjHnShy/pTm0/G2WDacRMLEhb6idpV21lhiDa0RM0P1WOkTGdsWSfNXRzq8P9XxndM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K2oMv4Ph; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K2oMv4Ph"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-480001972b8so355317f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 01:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787905481; x=1788510281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O5WOzevUigWOfvNP1ZBXlR5N6XrxbOpV2Ns+iGTIr5g=;
        b=K2oMv4Phduf0Fr6pOzxZclhv3olmGqU6coN5ft4ZWEhAnn8ZttHZIxsQ0fLGpXqRp2
         MW64ocqJyjZm0KKeO+8WTtqqrRsL1hMk6Pax+Wxp99PEwgiZOYEopsd5vGpEFTBGY2nc
         OSDA3N/SzzIndIW0T08tuhzco2M0Mzs9WwtIFK/l24WTajNqamP8N+1v3lcJngJvHLow
         uOlEs4RVQkQ2RBEjGsn8MUNgqatqRZQf/hprpb75WVl60aDJIVOWmcr5MV00slF1ExxL
         VpmQiKaEqSVGJiwBAKBBJRAtmk/wuMP9ApF30y/nKmYr6BtuLTQ/8ICLrbHIOyhDfquB
         LjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787905481; x=1788510281;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O5WOzevUigWOfvNP1ZBXlR5N6XrxbOpV2Ns+iGTIr5g=;
        b=DtgiBlYQudyWJrnoNvsCUpweK6ntLvhc+lHxuMw2AJWNe1zyBcAVEwfDD8PzE/0N8p
         0X7lZ7jZcq6+yc/Fmy7Id2eHVNSv0OvUGDNURaDk/Z92CtzSDMkgJEkf8kJMplqmiDCT
         n4LiJaFPs+SCAjYixwVk5oa/+OtD8/WoubntUlt6XMdtV/IpoIc/fNNBQEDXe+IHIFcs
         1D1x9iATbSV0y7Bghx8j1+iCjJpMvjDl4Wnr+QIh33brGAgEx3w5HHwD9za743OLG/FU
         RhmaMmOIW31UMucbB7nBcY7Uqg+hsTCPq04KtLl6PzcJ602ohyTEdCBPKJfXxV+drrvR
         ANOQ==
X-Forwarded-Encrypted: i=1; AHgh+RoBI3f4cxENdISfgnAwDNKDo8BVQeTzKhYeJSckUsYOXRT4RznVi0/z4+TH+L5Qr6nTrueu60ID/2Iol54TU4lWYLY=@vger.kernel.org
X-Gm-Message-State: AFuF++nFQPSjjWD87L9bxpo6e8oRoUE6MkyTfDB85vNUhJ8KcR+4bY/g
	TOoDSoclEyMU6YbJdOLtgxWXQm24sSwBC2CrjxeSCkPCrjFXwU+PEmtulwt4fyl4Ew==
X-Gm-Gg: AR+sD13c51SoQoa2o8cpHXpNawmV/ipD2+CeR3y1AeIfd8TlG+EAg1gljd+tOvHaOKQ
	dM/hoIGtAYpwya7JMTWbntbsjPkXwgVF/fLWLFY5XCl4CQBTlNTd2NZMQQi5gFYQ6jirXVvpywH
	B1VXeAzoOd5xPIWqabKRN5XNCrpV681g2+tpqjuQrNbTOoEx2OfemXKaXKCOcdjTuBdcVdYCIlk
	PS8OGgQcfWXyUYFM3LmLRJD5qm9l9fxKshtGlYeTS0hmdCFWm6WMS5/3/geoIlqhtTGUdb51Fru
	v0cvx6QDy857AY7HaMWNjDiFj4S2szK6r4Sl7REGxkyux32ChGBFn40TkxROggW+CWKJOnvXg/X
	j1cP7OecAtkkDCmf2KcTxERY6qzSqJjPuQjJEG+50BZygFCekL44hEbdIhYerSDwA80NHdJt2/0
	fDpCOaqCFNK4DDzBBv5qr1HgWZKzAFwy8yy0KoNmCvb8y5oyR0i7DR33EcnKa/bq0gLxehYm0nC
	AdnpxzlXKgCKnZenNONQN75YgiMo0xf
X-Received: by 2002:a05:6000:4008:b0:482:e2f2:19cb with SMTP id ffacd0b85a97d-482f79870f9mr6942058f8f.5.1787905481031;
        Fri, 28 Aug 2026 01:24:41 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb2072csm2023866f8f.23.2026.08.28.01.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:24:39 -0700 (PDT)
Date: Fri, 28 Aug 2026 09:24:36 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Message-ID: <apFFxOw_DUUChws5@google.com>
References: <20260826094528.3738023-1-vdonnefort@google.com>
 <20260826094528.3738023-2-vdonnefort@google.com>
 <20260826095947.4FF8B1F000E9@smtp.kernel.org>
 <20260826103736.2b55b464@gandalf.local.home>
 <ao8TQ-SvhjYgy43-@google.com>
 <20260826143123.1b3e3854@gandalf.local.home>
 <ao_Zu0ThaWThj9YZ@google.com>
 <20260827091541.5d03e33c@gandalf.local.home>
 <apBhLDTEa_3yYZP5@google.com>
 <20260827153314.77218528@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827153314.77218528@gandalf.local.home>

On Thu, Aug 27, 2026 at 03:33:14PM -0400, Steven Rostedt wrote:
> On Thu, 27 Aug 2026 17:21:39 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > On Thu, Aug 27, 2026 at 09:15:41AM -0400, Steven Rostedt wrote:
> > > On Thu, 27 Aug 2026 07:31:23 +0100
> > > Vincent Donnefort <vdonnefort@google.com> wrote:
> > >   
> > > > Looking at the function again, shouldn't we add !rb_is_static(cpu_buffer) as
> > > > well to the full page test?  
> > > 
> > > Why? 
> > > 
> > > -- Steve  
> > 
> > So that the splice can make progress when the ring-buffer is presistent or
> > user-mapped. Or do we say that's expected behaviour? 
> > 
> 
> Ah yeah, I see. Hmm, looking at the code to see how this would work, I
> think I found another bug. Let me look deeper into it.
> 
> -- Steve

A bug if we allow rb_is_static()?

If not, shall I add it to my series?

-- 
Vincent
