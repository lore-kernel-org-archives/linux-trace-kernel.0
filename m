Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815781537C3;
	Fri, 29 Nov 2024 02:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732848684; cv=none; b=TBHp6QI2t0lMDm6a+dcyvGOjKgt55ihiA6CAKNWH0bAYjsfdeDKMIJXwacD5706xG6RyxyybfxqTZgarGjRs1Luoocw+3dIL+SVUDeLsY/wMPS57ugYL5avOYUWLwssiNG6iCzrPBxg8xIWJp9nL2b6bbka5eR2R42Thv7n6XcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732848684; c=relaxed/simple;
	bh=HqjvvaETLV7NmYB5t4n5WnLo9kOO0Dl92NZK2+Gd/jQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M0N0Yc6DD1d2v7OpKhmmByhLdt1VjZyw3JUy3WWJZMK9vsDVr3i7E/F8aCxhVV7H9jVGEAiuHETr5ZsmTOk1C+FK/Cu+rP+GDmCpQPpTfGZ4FBNN00/qJxltb82bCO4p0E0Bb7JlNapzLDfTlg1jRQC9/o5djhs3T6SiCRooz+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ip5/7ChZ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ip5/7ChZ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee397a82f6so679148a91.2;
        Thu, 28 Nov 2024 18:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732848683; x=1733453483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4L2VxERU3TBj2Pof5ovdbNiNUOjLf2XnYjt3cV2YeRg=;
        b=Ip5/7ChZEKY7krCiO/UVYrLixp8rDKmnkvVG5YWGrjIizQ+N8Jdsn8dNo8XgAZ96jG
         +6QpUmFC9QsBgK0E1/i4nwuVSWEGnGk8HdOCt8RHWvMW+QA80LdaveaRwnjr/BQ9NjNy
         z4kKfZX00NJ79K/yNLFtXqJdM0QNX5BW2aliwdyTLPRHrsEwGuS8+SfmzWSotRL2rGYu
         c88AiooWJMtoDMdm18oFVWyGoRAh9VkatP90Hm7JCdZgQsk2mqlTurp9YNNN3MYtK3nW
         kzaF0J3P3SzkAQpM7p0Aoz0LvJxTkFUanGzLB3RIsmeYxJoXK3MvqAVOdKMVewqld7fy
         bvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732848683; x=1733453483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4L2VxERU3TBj2Pof5ovdbNiNUOjLf2XnYjt3cV2YeRg=;
        b=c1EqB7abrDF+gaVrdrCW0ytkBIgOJERPDFXlmMyMAzhQFXmh7ttmtNlEHRe0sOcupx
         6Lu5i9gx7o8bST+PuP66Tow2IEvboRAwnEpdTu0T3DGdoGQDdn4CWEYU5EFZGz953av/
         bU0VpQFtGnzUCxQX0PfnIL+DtibV7OZegCkwNCkLt7mH3SLmR/O3LJt2b0Mr6PDeEJTq
         wUUqPAF1+VSH/IWHX/3nUs3jmHZlyxmQ/fya4ipnHXnJnNIGdXUzRZDi3PbX4zDnArTD
         tvrH3TzXCzCBSCEvk/iMgcG+YE23cpD04DuZeWV6TNEhj8SNNKM0UeInDH5/nKHQDaaG
         X2mA==
X-Forwarded-Encrypted: i=1; AJvYcCUY5w5fMfRmpGBPOzZfFZfw3iLlDzLvRTaE77XcIJ/9AZGTC/wqxTgm11VyXeVvm7wB5UDQCgAIA/uRiJGGJjCwNLcQ@vger.kernel.org, AJvYcCVFL9Ftq734qGWBqROEJUVe2OMXApEobkYEyRj4gAhl64Gt0/BNQ9b5Z4DRh2QTLVR3X3Zdxb0ucUAMlsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2wEUGEkj1V3LWzg0EbLBjzLJ6WGa5X2pocmcnetBOMQIeye6N
	9Jb1pahIZqLVqGW5c9EBvXu7WwivqVhrVUtraSjV+/Zkl9L91Y9X
X-Gm-Gg: ASbGncvzyJ5vxvDfA6q7cLkias6mwS4t+Ar1Roap9H8q4bGDoZXQwrSlM4X6PxABBel
	RYSvX0OPwZGmw0OOp1TCW1nETncyhVKFBMb7b/H5cGH72dhHyv+NNgPGWsNSbvxzE+MUTna0uWD
	JfAyeIooKdd76rsFJc/ilGlJK0900RpXIBfbRC/dHxUElJ+VV7i2d1m98R12wemON1Yz/Qtg/00
	E0bCDgksxIc4tUqFIU5P6Dt9AjpHsFGHF42T5sdZHyzncFjbf6Rv6PZeon0u7txlIxtaA==
X-Google-Smtp-Source: AGHT+IHQzh62rT5i/Zv9To3noz+LUqqllCXEBXNVDp+GddGcKUnzSK+XxcOycuIx/R+AHiY/0hGtcA==
X-Received: by 2002:a17:90b:3b41:b0:2ea:3777:7730 with SMTP id 98e67ed59e1d1-2ee08e9fdb9mr12039591a91.10.1732848682543;
        Thu, 28 Nov 2024 18:51:22 -0800 (PST)
Received: from [172.23.161.188] ([183.134.211.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee46f19e4csm1073690a91.16.2024.11.28.18.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 18:51:22 -0800 (PST)
Message-ID: <2bc6b1e4-6d39-4bae-85cf-0d0eca077667@gmail.com>
Date: Fri, 29 Nov 2024 10:51:18 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Add WARN_ON_ONCE for syscall_nr check
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20241128115319.305523-1-chen.dylane@gmail.com>
 <20241128074623.063bf253@rorschach.local.home>
 <8d4796dc-ef5b-43d8-8ec0-3891b7994428@gmail.com>
 <20241128100324.05bc4c32@gandalf.local.home>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <20241128100324.05bc4c32@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/11/28 23:03, Steven Rostedt 写道:
> On Thu, 28 Nov 2024 21:15:31 +0800
> Tao Chen <chen.dylane@gmail.com> wrote:
> 
>> Hi, Steve, thank you for your reply, as you say, so what about
>> pr_warn_once api just to print something ?
> 
> A better solution is for there to be a return code or something where the
> tracers (perf or ftrace) can record in the trace that the system call is
> not supported.
> 
> -- Steve

Hi，Steve，thank you for your suggestion. I'll see if it can be implemented.

-- 
Best Regards
Dylane Chen
