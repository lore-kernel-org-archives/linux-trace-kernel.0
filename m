Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com [207.54.77.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA35230EF80;
	Wed,  1 Jul 2026 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.77.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782915301; cv=none; b=j0i0F+n5GNmYSOQ/CGOUzbTcjbkCPSvgMZU0wCJGOWc/TpL6nRvUkukPrZLbADmMrq/mQeqtMbAmGe1NxRiU6OJgpA3hjZWqEFuyTRgO+c3MOZ5ujcRh4c78fEOYlIMGAN/t0Fgo4RVS9ulmprpIZ5SXiVKoYwWm9hwqPJjjGbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782915301; c=relaxed/simple;
	bh=CEVGvu6TCDiaCcSvmrd98Os19avfl2PEiaB4Dw/9jcE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bqw76IZmKOTLxvrjrrRJOhAOkm2ct1ArDLuAAkEg86ANMlkpbKMTkuIIC8ocNkGxo+Ybe2FNkYChlQctIjMOQS5WopyUbIqdODlF6np+oOzJgTSSz6NLje8shLhwA8EsgO7OYPGoMaXa9YRqcu5ldec0oWDFACYwsRc8frVkGdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=VlJMmE+c reason="key not found in DNS"; arc=none smtp.client-ip=207.54.77.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="VlJMmE+c"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782915298; x=1814451298;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CEVGvu6TCDiaCcSvmrd98Os19avfl2PEiaB4Dw/9jcE=;
  b=VlJMmE+c08YG+ffwC0IIvEbUHCedK3GRwq+WaUWF1m3etF2rihGNmwxD
   dJFJ0sptiWAHoVCwHKGKd92YpPeAWu716st6Cv6+nEwbePxcHGHqMDBM1
   QNiW3+4ygVPn0gOpLxIwHsZ6XwZ+bZVcSFpbkY8ik4r+xPpPOtkpiSkpQ
   lpCSkQZic71absDOpQjKdI9Gy3mA9bdqUoLPEb0NaoUvPfi35qR2VYJJ4
   PkhN3l+ULo8nmbKKRoEEfncUNp4bUTC1lVU9XgNLfG8azMPGByv3FiNdr
   wLHFxLUbi7en54c4Am9LVeTAUemKIGL/U4/udRvuPBQR6a0IgQlf2MDbf
   A==;
X-CSE-ConnectionGUID: f9ca5hMFQ12iYAMawGVGGg==
X-CSE-MsgGUID: gqZxerLRTgyhwn+roZ+fdQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 17:13:46 +0300
X-CSE-ConnectionGUID: ErA3OLcJQ1yRxQuQaa7WWQ==
X-CSE-MsgGUID: Zaseidf5QfKEyJp5AqiCaA==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces02_data.me-corp.lan with SMTP; 01 Jul 2026 17:19:05 +0300
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Wed, 01 Jul 2026 17:13:45 +0300
Date: Wed, 1 Jul 2026 16:46:48 +0300
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/7] i2c: nomadik: optimize layout of struct nmk_i2c_dev
Message-Id: <20260701164648.93eca0250e8a4932611a2ce5@mobileye.com>
In-Reply-To: <CAD++jLmqtG-j=Q-Ctr-1-GKVqYzcwOwWUF6AYHcKf5aXUSKE5A@mail.gmail.com>
References: <20260623-i2c-fault-reporting-v1-0-6db1a8aabf18@mobileye.com>
	<20260623-i2c-fault-reporting-v1-2-6db1a8aabf18@mobileye.com>
	<CAD++jLmqtG-j=Q-Ctr-1-GKVqYzcwOwWUF6AYHcKf5aXUSKE5A@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 00:36:49 +0200
Linus Walleij <linusw@kernel.org> wrote:

> Hi Dmitry,
>
> thanks for your patch!
>
> Also nice to see some kernel contributions directly from
> MobilEye!

Thanks for you review!

> >  struct nmk_i2c_dev {
> >         struct i2c_vendor_data          *vendor;
> > @@ -206,13 +206,13 @@ struct nmk_i2c_dev {
> >         u32                             clk_freq;
> >         unsigned char                   tft;
> >         unsigned char                   rft;
>
> ^
> Maybe you want to take the opportunity to change these
> two into u8 if you're anyway changing the layout of this
> struct?

I'm waiting for review of patch 1 in the set. If I need to submit next
version of the patchset, I'll change these two unsigned chars, as well
as `unsigned char *buffer` in `struct i2c_nmk_client`, into u8.

Best Regards,
--
Dmitry Guzman <Dmitry.Guzman@mobileye.com>

