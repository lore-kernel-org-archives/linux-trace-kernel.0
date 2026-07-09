Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA36A39DBE5;
	Thu,  9 Jul 2026 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783617048; cv=none; b=SQFLyDFuacJaVlhFY98ZZrqyRv2zEHo7UoOd/yLc9tlV0ioHXbhV0ta34KOuoQYiFrvz6y16YnND71mRxHz9CnesdCDgU0iLwhxqe1/9aLHyOUrw+5vFGB3hvy85dpNW113HV1ZBgOERh7NbzDf7OV5CQJXuKCLf3dVh4a2in4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783617048; c=relaxed/simple;
	bh=ujrkHBBbACdZtRRZVnvsCYywvPhs0LrGXCxbReccc8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1gZsO/fuPi21DOkdGII5DrhnSHN783+opL1Ux4+Xyz6dS+2SiaE8ccGBoJlSJjr+hWs0b2UoJxYnjrIfUzfQjyKgcJ+xLlU9EUnZbgrVXw+pxXSmqX825rwZOumUydnRBZqghJ0K82r/sF/g/EuVTdeyDPSfaHom8kvabPsYNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IR7P8s9K; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IR7P8s9K"
Message-ID: <35b80b88-f298-4ed6-8b63-d18fb3b19d8a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783617035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgOpjqF52B/S822e7B/IqpRWQIZC+4biZ7kPndH2s0o=;
	b=IR7P8s9K0MtTisRttjtRLj3QFSuUbaA9IFF1XGPE/YuIt2M8jTEphhzo7G4F8IEHLnJmsZ
	UdP387FOsMD+KkqJ63FADc0ugVUe3ywumfNT7wDVL6o9W3F4YKgduM36yjmkHCL0icfUPf
	3izD0vsgj7Xfowujb3YYeoiIvA/nOjA=
Date: Fri, 10 Jul 2026 01:10:29 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 15/17] selftests/verification: Fix wrong errexit
 assumption
To: Gabriele Monaco <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
 Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
 Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
 <20260625121440.116317-16-gmonaco@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20260625121440.116317-16-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/25/26 20:14, Gabriele Monaco wrote:
> RV selftest rely on bash errexit (set -e) to terminate with error, when
> a step is expected to return false, the following syntax is used:
> 
>    ! cmd
> 
> This however prevents the test from exiting when cmd is false (desired)
> but doesn't exit if cmd is true, since commands prefixed with ! are
> explicitly excluded from errexit.
> 
> Use the syntax
> 
>    ! cmd || false
> 
> Which ends up checking the exit value of ! cmd and supplies a false
> command for errexit to evaluate.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>


Reviewed-by: Wen Yang <wen.yang@linux.dev>


--
Best wishes,
Wen
