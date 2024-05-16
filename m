Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A877E147C67;
	Thu, 16 May 2024 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715865942; cv=none; b=u5y4pvPw2s5BE/7zSE1YOJD9jb2z2Tcn6v2juJ2gtb2FpPD/bwcK9FKbp7B8aRbKPb2+Q+DlA7rps9aLOUf2O50Kf7bS4JXdhT2cbOXohJtCNb5jHLU/HX+0NQWtZXcCo/n7V1gXSSoT3vxye6QZDikwUZ+RO+GuqE4goJ3XlHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715865942; c=relaxed/simple;
	bh=DTID0d2KyQR/8XiYolqjuMB/saokffSkjZ3E2d08u6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXofks9LwKRFSGQGadJLEIopgRoQaIYx2GSoQOtLT3EAlW92Rk8ZucucQC+IBg4HUOZGwDj0DsA6sYKVwClawVX+c93ROqSPII2q7fAx7gGrbWvCoXcUNGpDnftRRCKyZyc3KD4qY+XgT4jnv5ORGfU3qJQR41MgZttrRIan7bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kd/9POmk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kd/9POmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B363DC2BD11;
	Thu, 16 May 2024 13:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715865941;
	bh=DTID0d2KyQR/8XiYolqjuMB/saokffSkjZ3E2d08u6s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kd/9POmk6sAVT/dIQrtQahOW/w/liyZhYvG6lD3CmGDKPp0+e+IISQFD+/8feGQ0n
	 iTsoEp4+NfZxo6nr+9fR9kEp4gTBsJ+kgQyr6ad36xRhzf3WyJdaqbBB87GBmdg+FH
	 j4fshPF5vNLGPjPo5EVcRoOVoyVw2/xKOmXtdzH6V6s3x4VGLyXtF5aD3C/XWnQ8U8
	 kOjN2PBYa6UnoBvRZ5CLnkNXFDjH+fcqIXhFiEcFaMyqsaXJ22llRmYxzp1AigMZBG
	 wywUkBGcoh90/DrNM78YequKHs8P8gOzgkZ/0n3+0ZWij9enG04jNX0d6RGTU1LHsf
	 dmFQ4XsuA3HmQ==
Message-ID: <d1034c35-8737-4f8f-91c2-be53dfa73e57@kernel.org>
Date: Thu, 16 May 2024 15:25:37 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] rtla: Add --trace-buffer-size option
To: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Juri Lelli <juri.lelli@redhat.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Kacur <jkacur@redhat.com>
References: <cover.1713968967.git.bristot@kernel.org>
 <0281bfbd3b3fed11a0150a8645a1f9941a423c7a.1713968967.git.bristot@kernel.org>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <0281bfbd3b3fed11a0150a8645a1f9941a423c7a.1713968967.git.bristot@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/24 16:36, Daniel Bristot de Oliveira wrote:
> +			retval = trace_set_buffer_size(&record->trace, params->buffer_size);

This function appears on libtracefs from 1.6 up, so I need to update
the minimum required lib version to 1.6. I will send a v2 of this
patch only.

Thanks jkacur for pointing it to me, it happens on fedora 38.

-- Daniel
