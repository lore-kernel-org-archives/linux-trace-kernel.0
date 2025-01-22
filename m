Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A6C33E4;
	Wed, 22 Jan 2025 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737532789; cv=none; b=C3Zedxx4Qm+LjZ4XxKKk7zrcWr4mqGTlBdudfKUhtAgkUMPfIGnjm2V65p2MDrCpDyxxlEkHX+K/p1JM6wixgNvDCoEl7mXwNtpVJtd/V1VQZ/NhlYy4tTuVQVj27iEgQ+KmF4RPJZ1/+5S3Zgk0DqpV8qPiWQDvSNAOhL+kWA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737532789; c=relaxed/simple;
	bh=DO9ScQLPzmEb6bWoYtFrbFsCRrGywJR9xWz7ygH2hGE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Oc0CXbsEIDyMfaJdgZKF0EThdO7wVOYVD0Ojrhlyfbc807ThdkJksqH4EqnPcPP2DFPqMDCajbHE9bpV/aAV2WGB1pVT8W0lixs/Hvsp8wlwMJHBhkQDRdIaGZD//1kCbUCsiVEaxZ1634OYYbp85Hcn+4x6x/WAkUsmff1rYqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=slnSOf8r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bFt5G+kQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="slnSOf8r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bFt5G+kQ"
Date: Wed, 22 Jan 2025 08:59:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737532785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=DO9ScQLPzmEb6bWoYtFrbFsCRrGywJR9xWz7ygH2hGE=;
	b=slnSOf8rq0UAiNcVRsFW39UKN1BS53WrkQJ5f7NYArRdPjvm8QS6foXn2yxVrxCFGXiGxR
	AiC0YGucsjYElPEzS3X3iovEUC9XabXYWexwxnI7J6RyP0qvVYU2MpYNWRstkbETPOlyLY
	mlZxbjoihmD46y9KmOLcAyFf/Osbkokm21q/GFSztnZCYrfYtANU/lf9OxEXRnpK4UoALa
	d0ZCdAz6wNJP1Bcsj+MvfFYGfqJHwelVnesEYQTdRxug/KSz51v4DXGawhfD9XdN+QaFs4
	iFqV+eNT5Xv9KtklMatIZhZsUSaKsWpMc5USsEjEhnrF4VwpmqqCPMkoc84VnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737532785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=DO9ScQLPzmEb6bWoYtFrbFsCRrGywJR9xWz7ygH2hGE=;
	b=bFt5G+kQAxE7zUscJqMdjPspB1b9bHbu0Pq6U51jVIBJeji8E5Ef793m2oinFqeK4doqmg
	JTjjmdhe/0Qu7eBA==
From: Nam Cao <namcao@linutronix.de>
To: naveen@kernel.org, anil.s.keshavamurthy@intel.com, davem@davemloft.net,
	mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de
Subject: kprobe on local function
Message-ID: <20250122075939.qw7HsuMd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I installed a kretprobe on the function "rt_mutex_slowunlock". Although the
function is called, the probe is never hit.

The reason is because there are 3 copies of rt_mutex_slowunlock() in
vmlinux (at least for x86 defconfig + CONFIG_PREEMPT_RT). But probe point
is only installed in 1 copy.

Is this considered a bug? Or is kprobe not intended to be used for local
function? Should we modify kprobe to support such cases?

Best regards,
Nam
