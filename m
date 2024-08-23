Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5639618040;
	Fri, 23 Aug 2024 01:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724376902; cv=none; b=Y0C4N1//PZbKadqY7uk9zsj5qNO+Huek5QqSrvboHO5z1TUvQtru7HrVyJ9IhBA9YYqdstA4FzrJ87pjVHvKUS8PwkcIBR9MvFHu7KMhzSWuBS007uoFELzaBb85fufYR7otqDWYB2fqqvdE/yMFS096IfD2KqawuJvewsdlFw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724376902; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:Date:From:To; b=Sq2GifpxHbrG0cVPrT3LuVSs5DZgTEuKzmx4lX/VDAAB3v7yq1/2uvxwgokAvpd332QlCYssZ706kuHEQ+Bt3RlYAT2YCWupL9wXAnMv0ZbFP5RHRYRaU0S8sHI75RyW5Eb6yEklMdToVSshPcYipEc/AFEA17ET19RvQzHJUW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DE3C4AF09;
	Fri, 23 Aug 2024 01:35:02 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1shJDC-00000003ZaP-3QPi;
	Thu, 22 Aug 2024 21:35:34 -0400
Message-ID: <20240823013534.676820401@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 22 Aug 2024 21:28:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

