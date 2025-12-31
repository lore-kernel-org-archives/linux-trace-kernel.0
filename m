Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F6B2BDC28
	for <linux-trace-kernel@vger.kernel.org>; Wed, 31 Dec 2025 19:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767210641; cv=none; b=ApOnQlMyolZKMDu3sWeF/BEsw+xUs7zLJaAnsKSKhSlPRt9Y8wmKqwuDSVTWaWVjhldFdryhzBpZtWaTAfxJXzpgajJBSdZEgLHpnbOuwWX6/jlGTfrumRv5pez5AV8aU3V09ys9NNh0LSEwZuw6HR4ovMMQfhtkP40lcaUi3J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767210641; c=relaxed/simple;
	bh=ix6A3xdAGgEPcZZuGLAVhngUGZhbtrZp0DZi4eRO/0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bo3vpi7+/68o4TV+JC9sTtZuTOrQC9mLxY/Kh9SmnXnkmJ/UkfxCJytOq+qJVbKNO1mrA1e2BRSjja5rv/MAMSkRoMz3R7kpAkUlaFgEfvMpPlLJ/ekyey1QwIYG5sZu7KTPHQO1bJfAUkr0EKZn/hN/iJLaruDApuaLdQ91YOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BeZkhH6q; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BeZkhH6q"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3ec4d494383so7889987fac.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 31 Dec 2025 11:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1767210639; x=1767815439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t935BcvfZIHJZaYpgjJ/I78hG7hwYxgpYQ+T3oH/9z8=;
        b=BeZkhH6qiaEJaA5k0LcnYn4x8jaeyS5CKVF2tLAv3s1fxb/NNi9a5csweCJ9/moZ3t
         KhbGrlMPwEDL+yxT+etn4V+YD9i2FWLbqxRli7wd33inDwbRjKtfCytAdR/VAFSyOpr8
         Jv46gpwYmwva6oAHA8QK8ijXml9Q5c0b64WjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767210639; x=1767815439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t935BcvfZIHJZaYpgjJ/I78hG7hwYxgpYQ+T3oH/9z8=;
        b=KCCs2abfLvhvJ062mLap50XmK3kGYcjU9LUZFRLkOgyJVGBy/HGPNi1LDXy5L9HHzh
         4KPjuhuELzgtwhevp2Av/Abj5hmgi0Y5hGAmdjX0s5vo2ORK1+10V9GQ0LGz7kZGKveb
         S8K/f9hgU/Vax3qsgYYmY8/bdPZ8KkczOv6hTulrlYYKwadLQiMZOEqFVA7slsvadoRg
         2+LpDwjczhqCPJHFU4mFtPlgbMtmm0ivmuS6V51XjSDlztUfDaWarhKdIwLbYWCsu7ir
         E1pEcw22Tc5aONk+z7fLsYPQHVmsZ8fnXRJhcxPhDkJlUH+tqjkKuAqMbj99+hV9abph
         I69A==
X-Forwarded-Encrypted: i=1; AJvYcCXO9WqHNT0yjIjli5Vg756SBhAsSfKBoczg82CjSoizQjnyTorzDotcCU8VyeuNi9Cw6gqZ+cMu5PebYBCsm92XBec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5rMnrx1yFT1Iuxf+T89q3kJeJhg/KzH4SwM1J44oMfQr/4NnF
	3Y6clHUfTLbl1pP+ctImJp+N38VdQWnaGRSPdTMKSucddg2ANhoN65KduZ6dXGyDiCDaAluKVC+
	EbMPm
X-Gm-Gg: AY/fxX5aD3OzfBBwpPwmrds/LmgFcFZ5hQeLbTawcBp0E7Jaa618vF5SZbOUthZZ6KM
	mNBoo+SQ33ixSNkujNcxGZJNgavb1DiVGkvWVoKwgTH6KWFSUbyLivvW7HcKiraOGaKbRQYmbHN
	e/+8D7nYrF4TUjsd1DJtnJ8HvvkMUp41XDmrD8fioFPrCGGMHC60fgEeKta0B22g52Rx6Ljuege
	rgcMSaWgnWsi7WHZk0nrhFwEeAScG/dyfoLfnk9pwJfMKaxQT+1LGLAa/dIQhh+aOMTMlVbex0a
	s5X9fCpWfBvhT3pS1kKg6MgkcS49WL6BrsFptuXkUH23qYdTKIAlvuzC27X8cd4UIaHTi2p3ugW
	QSsCjJNnffIvMtc4idPnz4Se9jzUpIuJ0fieyPPwL7hIfFz6GRkG8462diOslJKFbIxGnNgjr9X
	toQBfGZaTiGJlHMyL8beSb/JE=
X-Google-Smtp-Source: AGHT+IExsHsLtfTSkxkO6eeVI5nXS93B+/uuZEmfne0eSd3+gbCVOw19HkivC6xibbumsjNLB697KQ==
X-Received: by 2002:a05:6871:6c12:b0:3f5:4172:22 with SMTP id 586e51a60fabf-3fda599f1e2mr19924623fac.59.1767210638842;
        Wed, 31 Dec 2025 11:50:38 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fdaac145bcsm20594782fac.22.2025.12.31.11.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 11:50:37 -0800 (PST)
Message-ID: <0d357c41-239b-4750-ae65-4c2c3734950f@linuxfoundation.org>
Date: Wed, 31 Dec 2025 12:50:36 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: Test toplevel-enable for instance
To: Steven Rostedt <rostedt@goodmis.org>,
 Zheng Yejian <zhengyejian1@huawei.com>
Cc: mhiramat@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20230509203659.1173917-1-zhengyejian1@huawei.com>
 <20230609174626.66659892@gandalf.local.home>
 <20230710175415.2ec0061f@gandalf.local.home>
 <20230907214020.34981ffd@gandalf.local.home>
 <20251218183040.0f652a64@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251218183040.0f652a64@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/25 16:30, Steven Rostedt wrote:
> On Thu, 7 Sep 2023 21:40:20 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> On Mon, 10 Jul 2023 17:54:36 -0400
>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>>> Hi Shuah,
>>>
>>> I think this dropped through the cracks. Can you take this through your
>>> tree?
>>
>> ping?
> 
> Found another one that never got applied.

Thanks for digging these up and others. It got buried deep
in my Inbox.

Applied to linux-kselftest fixes for the next rc

thanks,
-- Shuah
