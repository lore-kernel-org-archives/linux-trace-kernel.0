Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79611A4F34
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994205; cv=none; b=G3ZvvPHfGszZxgCHZgt1Ed4kcmkaQE/AtWonVPOC+2t90ps0B7mP02N66odKkAi62DEq4cGIoxNZ83vighUUyGsiXgWb7qGEvysnRc+xBZp9n+GJUZz/Uy3V4NBcJdNPKZwyGOhys/vyskLfIYYnmISOfXe2CLEyAxJgDmudz5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994205; c=relaxed/simple;
	bh=itBQXuelZA75Po5d9GzHrmHgnyq5aLaPbElZSW4ZNp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oe8kbUS1gV7IGushRrzLVEDFHWYgfwnaCytj562ouQs3S5QzBl/+wgws3pViALZ8l9+ICRrk+tZ4LFlcVE0uaaM6+WW3zC5DghxgY6XZfjgFsKF8UMsodMCWql8WaTWVTqrsB3WF9CwYx+HB1r3ZEkUHvhxWFXOfI4w+apsGoos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NNjTfkd/; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NNjTfkd/"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-39f4827a07aso23902895ab.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725994203; x=1726599003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2xzLBxLjgDj5rpC/iK1MnqiUkc34ZYC9aNRFEI6xVyM=;
        b=NNjTfkd/VBvsEsDkvZs4/SFKOlXxY9n/nJwRU4T/Oh1dkJVSiY1dd0wOYZuLBRCjGh
         shqIRGc+oAy9hftapFPap2qFzqXodqlrjAOBzo03SFegy52EDqPRcpVh5LRjrIal2ex+
         zQLN+Ipn3WpoREZ4JaDBbzPfuEV7CfP4zqYtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725994203; x=1726599003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xzLBxLjgDj5rpC/iK1MnqiUkc34ZYC9aNRFEI6xVyM=;
        b=jF8xMdJ7R/TsNlFrQ3GJutQB+7tyvlrOT9eqJf3tJ+dFZBTNEYn8WgGFeKRUXYT7t2
         h8BqB6oAxE3C662/B9rYK0RtFsQMWDfjeHyH0WphFA2EvwbhGsDyGukzDJSb2XT8y+bZ
         0ZvNQhGrzi2nhKnYljXaQdT9XX+6KpG/mOPtLJ9meql802KrZtzg3w/LjLdV4O6gYSQh
         ZBqhOPjcRJK5wfOY0aPhjNxd1DU3NZb4I0nGLtTWk3P572OWsHVRbZnS7nCGaygXrIe0
         QD7MW7+GJQq/9yTM9G7Stehxh7rr66V/umm0fl0F82ZmfjaYDgAw5yAtImRrfSxI8BN8
         8jMA==
X-Forwarded-Encrypted: i=1; AJvYcCVfPYANmq4YP6hFLYClq84tGij9ELs/8fQMvODzXvSt7Sif6rr/pvrod64+bsPOL774gyqJ2HlXyxRyBwHjBGYrx/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz61XtZ5fdzrYfNrgd4ew6gELD5KlXIV8r3eVVGzcM91ixr5RU5
	PnDgxD70e87fLFaJW5qXDEUZLOjMSMgpYtBEmpK0F8IYaA2ATHzWopIdvWPLpGE=
X-Google-Smtp-Source: AGHT+IFDdvfVtJxuoA+NPIZaRMPtLiYE16oR91YzbeNcdA/bJHDFPaffJkkcudyfvCuPdeiV0K22Gg==
X-Received: by 2002:a05:6e02:b2c:b0:398:36c0:7968 with SMTP id e9e14a558f8ab-3a04f0758camr187994025ab.6.1725994202880;
        Tue, 10 Sep 2024 11:50:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a058fe56dasm21533775ab.52.2024.09.10.11.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 11:50:02 -0700 (PDT)
Message-ID: <bf48db12-1e97-4690-b733-bad6b2363edb@linuxfoundation.org>
Date: Tue, 10 Sep 2024 12:50:01 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/2] ring-buffer/selftest: Handle meta-page bigger
 than the system
To: Steven Rostedt <rostedt@goodmis.org>,
 Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240910162335.2993310-1-vdonnefort@google.com>
 <20240910162335.2993310-3-vdonnefort@google.com>
 <20240910124555.180428eb@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240910124555.180428eb@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 10:45, Steven Rostedt wrote:
> 
> Shuah,
> 
> Can you take this through your tree?
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Yes I can take it through my tree.

> 
> -- Steve
> 
> On Tue, 10 Sep 2024 17:23:35 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
>> Handle the case where the meta-page content is bigger than the system
>> page-size. This prepares the ground for extending features covered by
>> the meta-page.
>>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> Cc: linux-kselftest@vger.kernel.org
>> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Vincent,

Can you please rebase these on linux-kselftest next branch and
resend. This patch doesn't apply.

Also please fix the subject to say:

selfttests/ring-buffer

thanks,
-- Shuah
