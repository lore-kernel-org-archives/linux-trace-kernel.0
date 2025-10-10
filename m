Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C8E16A956
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760106154; cv=none; b=kBBM4rD67sdrj981buJ8GNaFKLbN/mHuSCCBuz5JLrUqswcF87+uv0O3odlu085mRh5Uoqto/b/aVrElHP+YAZ96QYhlFZzNz5hufi+p9qdtCBhv4egKmARnHME8sYZiRgO9mrHn58ZcaJpCcX0qaV6rIAVSZNQhBsTW7Twe5mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760106154; c=relaxed/simple;
	bh=7dndPtRevbITE9ffdTBKfJlBf/TdoDeFhl4O+Fj03Os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CiY4zVTnD43Vh9LnOY62jL3/SlqC1uxICX4lv7OG2INd+so4l6MV7EnTGOp8etjkoy4MK/8hZnpou4E7I5jQQV4f1O9oQcM0lrz+fkq1oe1k2ucZJVPO9ag+V2M0Hf7C/+Fi5UEjTD2MQ6Gv9gRYtlw7ZuQYWA/F8FfTGUJgEwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0pDKvYp; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0pDKvYp"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7841da939deso1954519b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760106152; x=1760710952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9CuwuYd6rsM2ZdZipwD4GPWKHOfizRXrtv5NCir+9FI=;
        b=i0pDKvYprOqKTUOvlTb0+Kwemaf4fSwtBs0seoQFE0Utg5Sr+RMW8UILA/0c3A98ji
         9RNY51cIh+lXObvmkLfZC+62DbEOQudHH3I3jzbC8KlAK3cRYauXcUQJwUz/UY+HLSGG
         cfjAWYUZ/ptTnnqO1stxYZq/fQzxSncXvVJkPS+WgeWpkeTFif7vkbrzjBYNnps3/x/Y
         zahLYrbRNKe4zU6dUP9d1IfRGImscJ6QkWvi6zdUjKBZp2ftW3uZjkyjSObad42b8syh
         JF8Av+bJcGJqs8/9LZQbbGeAgI6kdKS2WKtk3WY62/MqRJ1Tow3yv/MLHFGmD5SAEYeC
         BI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760106152; x=1760710952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9CuwuYd6rsM2ZdZipwD4GPWKHOfizRXrtv5NCir+9FI=;
        b=r77P7p6qlGJP1ycWvnubl5FWVYqclhK6XYfkJb+8f/32Spi/QLPD1AX4GvaDoZfvGv
         NiaZV8oIuNGCokFRh7Q6/aiR1IWNZ8sXE08TeLKmbX3XDo969qbEmQVMLPXbwW/ridjj
         aVNthkaIWSLrkLWRQv8R/uT7VsVUMO1IRSkdMaHg9YgCCNJW4VZqXSjzGHVTFVMn5tDE
         7HhsN+W9dbCM+TERvqKExmD/SmJkhxTHi9aZ9PAhl2ZOHq3bpqwnc/WzXo6Hr6tl7C+E
         B6gxTNy+cWDZJU8GY6/YOkg89F2IOYZBn6Ja0Q6GrWF2uQyVKd/KzGe+my7ho1Mg7cwA
         D29w==
X-Forwarded-Encrypted: i=1; AJvYcCVFYTTATql1EB5V1VDUZK2XlghLj38gjomFk46/RqPMuAYd6mSmqaQ0gamkGnCnhkxw6k2l+W5292GPZ3vltj+7X2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu9JdvrjfGcxqf34Rs+TRX3oqAV3h3/K0YCIPAaV58mMuAJ2Dp
	CC6781nFFjD0IGyP00iuMh6EB82m/p/gDYhwYUYMmYnChwPunQnWm/oF
X-Gm-Gg: ASbGncsU3OcdsguGaRwJp3dTit8DqvYhlM+uYLGj5I1rUDGFsiUcMY2Gm5sITZPIn7G
	dTqUehkXtSOfMAwwLEgqY0i+WAxe31HG/EfYvPCKtfg5tgxSuJ5yll29sMmhzCoQcQ4P+6wWFp+
	XAheC7RhIok8BnLIH5AbXYkoyeoTkWBTUMOcbjtplJynzIr3m0ZfKAnBiEATP70B0PyUSIs9fuI
	myGtxOMnUU0zV0hNwJskCAMr2lJv9OQuL5RgV+100LlaiLjuu9aXdK5IN7q55pI+L0chDpHms/u
	Mlx/Aq6F3XynpZSXwztjqyJpGtg64+s25z8QQtwDybgTit0ZVO3PicnnIE7UeOL+eA0AfU3CjfE
	w38Ya5a9MNmV4qhzgEs8hCVZ8gaivJ6+g7LW+3WMJYoTGN2vK2WMHJYnwGeZ2dnahjFqr6rGEYg
	w=
X-Google-Smtp-Source: AGHT+IH1+iBy8nFHwk58M7adbDk6CNfAFBIzVimB+kebnYyWU9N7MoWT9usmV/V05WE/d2nIHvMYkQ==
X-Received: by 2002:a17:903:4b50:b0:246:a543:199 with SMTP id d9443c01a7336-2902741e471mr151973715ad.54.1760106152226;
        Fri, 10 Oct 2025 07:22:32 -0700 (PDT)
Received: from [172.20.10.4] ([117.20.154.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f8f9bbsm58596885ad.121.2025.10.10.07.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 07:22:31 -0700 (PDT)
Message-ID: <5c68715e-d851-44cc-ba14-0886e515ef45@gmail.com>
Date: Fri, 10 Oct 2025 22:22:18 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bpf_errno. Was: [PATCH RFC bpf-next 1/3] bpf: report probe fault
 to BPF stderr
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Menglong Dong <menglong.dong@linux.dev>,
 Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, jiang.biao@linux.dev
References: <20250927061210.194502-1-menglong.dong@linux.dev>
 <20250927061210.194502-2-menglong.dong@linux.dev>
 <CAADnVQJAdAxEOWT6avzwq6ZrXhEdovhx3yibgA6T8wnMEnnAjg@mail.gmail.com>
 <3571660.QJadu78ljV@7950hx> <7f28937c-121a-4ea8-b66a-9da3be8bccad@gmail.com>
 <CAADnVQLxpUmjbsHeNizRMDkY1a4_gLD0VBFWS8QMYHzpYBs4EQ@mail.gmail.com>
 <405caf71-315d-46a4-af35-c1fd53470b91@gmail.com>
 <CAADnVQK8Rw19Z6ib0CfK0cMHUsYBuhEv8_464knZ4qFZ6Gfv2g@mail.gmail.com>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQK8Rw19Z6ib0CfK0cMHUsYBuhEv8_464knZ4qFZ6Gfv2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025/10/9 22:45, Alexei Starovoitov wrote:
> On Thu, Oct 9, 2025 at 7:15 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>>
>> The verifier can rewrite 'bpf_reg_aux()' into the following instructions:
>>
>> dst_reg = BPF_REG_AUX;
>> BPF_REG_AUX = 0; /* clear BPF_REG_AUX */
>>
>> As for the architecture-specific implementation, BPF_REG_AUX can be
>> mapped to an appropriate register per arch — for example, r11 on x86_64.
> 
> it's taken. There are no free registers.

Understood.

It would certainly be beneficial if there were available registers on
x86_64, as that would enable certain optimizations and improvements.

In a similar direction, I have been exploring the idea of introducing a
dedicated BPF_REG_TAIL_CALL register to unify the handling of
tail_call_cnt in the verifier. This could help standardize the logic
across architectures, particularly for those that already employ a
dedicated register for tail calls, and allow JIT backends to simplify
their tail call implementations accordingly.

Thanks,
Leon

