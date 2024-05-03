Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EBC57C9F
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 May 2024 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714763579; cv=none; b=r0iSd3mLuDMz0tBBT2KlXAEzGN3l08SxG10L4ZI5LJFCHM7K/neYxYTSO0n3hIeQLx9agMP4m5h0NEHjR+z9Qui9H/Yke2b7RBpxuRLhJ5fIWjJjt8HgFzVWzEnuyci/uy835Dmiqs3HNNYt/iuUYQ0BKqc/gdlBC3gfo7Au1Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714763579; c=relaxed/simple;
	bh=IKLI/Q78RF9vVx/YNe7wLdlLEK7x6bEXRB/vPUdT3wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkHk8O+tpGnsjXbEDGnhu8Q7X8PH9KoKVBXcmZpGc5dY+fChNUX28XwFIp8MKOFoSGMT0PPu5XFAtweuwqEly1gmLs9MXneTlx3nzyBer5y82tgw+q97vgMuyZa6jhOb+hkTfENnKHKalDO7v1KHGOTSK3fOEInA8Yo92kzNwzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FqSlnwW0; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FqSlnwW0"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7decb824727so95239f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 May 2024 12:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714763577; x=1715368377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oRFjxSyK4Qq5KgEaM3tSc2tgl3ftVperAuW9pNscAzY=;
        b=FqSlnwW0XPXoF59LD+Sgdo5WKNnTnvh3nx7Hirad8Vwmjb9gkuBEYSHDeimXi8zpNb
         Uhf4Nms/vy+JgftFkQzelYUkvbx3IP0cqmVeTuIHLkd5oMY6kc8tSJfE12xn5/gU39cc
         QM4d7a2NXO7zlYBJzCBDnqjhXs65Yif01xrSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714763577; x=1715368377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRFjxSyK4Qq5KgEaM3tSc2tgl3ftVperAuW9pNscAzY=;
        b=Vn+HCw2bEdehDF4ZyFXwSUEQ6dh86m+W5MXbWCHGoaBfg1sCecqTQTjq3dEdHbOC/R
         1YGrRpM2U2NYRA6z3lKOYxKXTOnuuNRWcWgmsJOKljY8+u4SwIvPMePzPVwBnhbOg0Jp
         akV2m9GkKwC7vf7tIMcNqIriD7rPBATkvZNwqpoQtgMcZBjLmL6KHMU3nBbRFPZF/Nci
         X+ODx9RbO3t92aihmMGVKSnZ5+o4tVH340TPSj4nRlls0KHzOB6zkVSf/oVioVPVdoGB
         bP3zWb+cdkPO45R0h0fLkv6fWePNx6PtJO3zCXqkhWEAgR5YYPI/C6ULsmIHWWQzqIns
         t8aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiOt0pljqf3EGKJnHWoaoYgb47vhLBuviSybNJCVECukBwSLVVGTHL+S5HSrBWp1CmjWFt/ftzLwDo0rcebX7yJBJpYdve65CFrF/XdBr7GXTy
X-Gm-Message-State: AOJu0YymXN58eV+VPu/3VWwKpGEOxyZ4pPLMMoB/hBgrL6nZnqYpsN9i
	U0zRsZc4sgmyjzl51MdK9nTtJU84dUVaM+0bFOki1pVwxaPe1Xcj9tscuBHuWfKU6HHJRNNlMtr
	8UTE=
X-Google-Smtp-Source: AGHT+IFeCr1sXlKuk6y/+HaEO2vkq/lW4xsCt4vEoT13BLeE623tRhqnA0qvoG5XspHJUW7YimhDEg==
X-Received: by 2002:a5d:860e:0:b0:7d9:eeb8:ddeb with SMTP id f14-20020a5d860e000000b007d9eeb8ddebmr3581267iol.2.1714763577683;
        Fri, 03 May 2024 12:12:57 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id g6-20020a056602150600b007deeb2d7c4csm786391iow.12.2024.05.03.12.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 12:12:57 -0700 (PDT)
Message-ID: <5bdb08a2-0740-4ea0-be24-a948332d60ac@linuxfoundation.org>
Date: Fri, 3 May 2024 13:12:56 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 5/5] ring-buffer/selftest: Add ring-buffer mapping
 test
To: Vincent Donnefort <vdonnefort@google.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com,
 rdunlap@infradead.org, rppt@kernel.org, david@redhat.com,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240430111354.637356-1-vdonnefort@google.com>
 <20240430111354.637356-6-vdonnefort@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240430111354.637356-6-vdonnefort@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 05:13, Vincent Donnefort wrote:
> This test maps a ring-buffer and validate the meta-page after reset and
> after emitting few events.
> 

Changelog needs to be imperative - refer to the following:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Update the change log and describe what the test does and include
test output.

If the test requires root privileges - make sure add a check to skip
when a normal use runs the test.

The rest looks good.

thanks,
-- Shuah
