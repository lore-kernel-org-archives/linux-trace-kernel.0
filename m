Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C722EEE8C;
	Thu,  8 Oct 2026 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469266; cv=none; b=q24ZP9rz2oYqlVn6uQ1eGjxKYbmuxO3zFfVMC0+BwdydLjBQXykpncrctf1Gfg16XCCPMof63XkhDMsSo1QXK+mCNcTLZcc5tSbWh9wbBXtuTDHpY9MkHnghmNuv9POEbFu/BEgL/8hcfY34HujIq/Ys1HLwmRy/StztM6ViXCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469266; c=relaxed/simple;
	bh=sFenLdRxQYzWXBKWT6dXvzynEAd3IlBikJ3SLR9BrFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVdFL6W3XaBtX8yRudPV5Ih4IQ4mZArM1nGDab04qMtPw6iLFf4dzLk3SaWN/czkzIv2+83/4EYv3/GKzJmjeUAZRyH66oGEkDkLoylrobJGQ0FgoIejO9phk2qk440+6CXukqyocs0uGuy1XnL9xo+GsFYQbbRpaU0CUtkake0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qHJnX7Fu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qHJnX7Fu"
Received: from jeffbarnes-ThinkPad-P14s-Gen-2i.corp.microsoft.com (unknown [52.167.112.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id E209A20B7166;
	Thu,  8 Oct 2026 07:20:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E209A20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791469207;
	bh=sFenLdRxQYzWXBKWT6dXvzynEAd3IlBikJ3SLR9BrFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qHJnX7FudLAz1ZydCIvLp85i0GYxzaBMrSkSkbUeRy/xVpLJI2RWnwFAUU7xUaFl6
	 j77S3PJKcqNRLB6BLhpUa5p+NSqtlPTGvNBILIHcwVKwrmt3JCuIc1Si4bMfhjgNoy
	 akyCQ9Oj7IbP+13FvJfqlU/Fa+fH9nGMV2gNGCrE=
From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
To: linux-trace-kernel@vger.kernel.org
Cc: mhiramat@kernel.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	kees@kernel.org
Subject: Re: [PATCH] tracing/user_events: Fail fork when event state duplication fails
Date: Thu,  8 Oct 2026 10:20:54 -0400
Message-ID: <20261008142054.89783-1-jeffbarnes@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002222639.1964370-1-jeffbarnes@linux.microsoft.com>
References: <20261002222639.1964370-1-jeffbarnes@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Gentle ping on this fix for the user_events fork error path. Please let
me know if there are concerns with failing fork when user_event_mm
duplication fails, or if additional testing would be helpful.

Thanks,
Jeff
