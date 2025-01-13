Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C61CAA9F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Jan 2025 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736808909; cv=none; b=h7zmKcd4Jgn6IaDnBmqdwytNrOhNAABfS3x5FMhLUv+DBA+5s/XKdHCp1piMJ1ioVlU13LLZa6ULI47jVC75gK8eLIMDVlsruLrjoeJQKj9h0wayTp0HmtpFfBrj61IJ+XG6tw8LN22UvXTrU4sHglpT6fmv8jOTTa9lbiULdtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736808909; c=relaxed/simple;
	bh=vkipq98eiuOQy7kWpyrNKFUnOaO4Hf/hTSg9Tud/Wo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=niqvzmCDvdyRPfq1MbwnWRgbkYAON1XD5mFXILv3DCGUkuh0rRTsDDZdrD3BHp+yE8LWxffu4k+o9pMIKXhrBQKU4BmUcc28FVy+/B+6YQIE3rcnvfg1ClVr85Y4T9cqGE0ggwSFkg4uC3lJGgWPyKzcUGEJZTSwBGnxtCiAEEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E/umheod; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E/umheod"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a9cdcec53fso35348365ab.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Jan 2025 14:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736808906; x=1737413706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ACh5EO2+ycjbq2FN4kF3D56JbKZG03WJC6qrYAkuDJQ=;
        b=E/umheodbrXJthE8cr/GhrDCEPH8F+csiBB341oPyiGAJKeZUd1RChJicsRpFdfHd5
         lTFRKGEPhjfST6rB3HX72qto74WAqhjNGYqFfEIZPY8dCA9BLQCE4H8XJ715atj+gfHB
         x0aaiz9uyeJnqQJi8Q0hGrTkQ2hQgrcrxuV00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736808906; x=1737413706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACh5EO2+ycjbq2FN4kF3D56JbKZG03WJC6qrYAkuDJQ=;
        b=NvD6PHYoAgWcAZXfXK/TbZuY5s79nTtO3K0NvN0KKlaZeKDT5WQgZNqdjQ3R20h7LB
         29FYBMGK6rVtRkgFBIxT6TEloP+LBVhlEuO1cVsL4EagzkJaTEbflkNTlFS95VKtj2bI
         gCbT35vD2pgJs/zCeWFSvlD/HcKGjFHmLySyYXxlIYn4gXxL9IojPX7TcnzPv5gufJRL
         YoOgqe/qq1lvMjvuYN8Q4ZCCpFoRtrIPDIZd+GcnKpHMDnJfbw8STsK97uxgkvtMV/QZ
         lTSXKHryPlZwxETFyqnfKwEauV0qumpDfFs7Igwmd5rQ9cpfJ07f2UjIbKrp+pmRbnkh
         bVtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUje58AJtwe62NuWRHrSUeEd8bYvMgcrDsgPTk1CIzzKuL1o+vowFFf7pXOtxDIrvPQZZ+ay2z0krJGNa/ajVH4OXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUz/wni10FpKf9k6aP0lP25NXyCHP4uy7ZISpvajdpLBP78Si4
	RvQWEXy/jVDu3+hgPn7SbUgSw10dtL5l9CpTotDuSCbwPxuzZOwmw7+KDYCLTbU=
X-Gm-Gg: ASbGncsMa83FHtKnAMEMh0sKP6F7QBKvjxFqAbt5dOZIRPugP9qWRv+Fh9fKLPO8Una
	VcilSuwNxK2IuLwC/p/iCkKvNferUhILQO18ozba/lK+/HIdVP0Yfw/b66iVlp6ng2K0GJag4Ps
	dEGvulHpOUng984/mT/GUqTz3Mna1656+rlfobSLfk5+Px7C94Hh+CZ9lST8oqK5cjK2eVluPhm
	fi/VYGnxy1B5xHHkFa+dGIS7LrTBRvfPgflgTQmeO32kop/MtsQOJzpYHHXiO98h2U=
X-Google-Smtp-Source: AGHT+IGCGX3p/H8zPoC4bzSxi3Glhut+QAz2DFVy5lIgY0UGNwRfbSr5gyfb3+A3zfW9W+Bc+ehgng==
X-Received: by 2002:a05:6e02:1f02:b0:3a7:c5b1:a55e with SMTP id e9e14a558f8ab-3ce3a7a8aa1mr181433625ab.0.1736808906566;
        Mon, 13 Jan 2025 14:55:06 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b613391sm3036239173.47.2025.01.13.14.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 14:55:05 -0800 (PST)
Message-ID: <bea75a31-2778-4065-ac50-1a9e75cde2da@linuxfoundation.org>
Date: Mon, 13 Jan 2025 15:55:05 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] selftests/ftrace: Fix ftracetest test cases
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <173625185823.1383744.4020760882101555349.stgit@devnote2>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <173625185823.1383744.4020760882101555349.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/7/25 05:10, Masami Hiramatsu (Google) wrote:
> Here is a couple of patches to fix issues. I think mount_options.tc's one
> is a real bug(I'm not sure how it worked), but another one is an enhancement
> for (my) execution environment.
> Anyway, those should go through kselftests tree.
> 
> Thank you,
> ---
> 
> Masami Hiramatsu (Google) (2):
>        selftests/ftrace: Fix to use remount when testing mount GID option
>        selftests/ftrace: Make uprobe test more robust against binary name
> 
> 
>   .../ftrace/test.d/00basic/mount_options.tc         |    8 ++++----
>   .../ftrace/test.d/dynevent/add_remove_uprobe.tc    |    4 +++-
>   2 files changed, 7 insertions(+), 5 deletions(-)
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

I applied these two patches to linux-kselftest next fro Linux 6.14-rc1

thanks,
-- Shuah
