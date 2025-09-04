Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1422244670;
	Thu,  4 Sep 2025 18:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012160; cv=none; b=d9mj2yJFv7riLd253Gyx5lGIDueckByWNlibg1tLp7V0dQNnKqy5iI146d7URzB6/bHoRdqDMeMd7tXx2m/pSl+5J3Wmk5gsKX+jbknO7ylcGG/ANDWjNotgfXL0sCp6TagifUAUzT8ZMbJZPlw1zmN0fTjsSEs25oJyZjxxnvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012160; c=relaxed/simple;
	bh=x+816UkHLyRvuKb/oS0wEATvXuUn8rJpVOodqIFEeMc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sOoPRU/BjUiCxS0Ic3HSEaKFSSCAf5BHdJWuAwV4wvF0NiaY2xg7JYQis4aNrKOF5LcsirVrZTYxQ2Q5qlJa5Q2TTp+b+RvkD1cAf5lwnGWZ3kAczE07QFOSMuFrpxjYtLZEieR56NSH4B3FyiMmcoyxcv0R76DUZR8dl3Q6ds0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK7WDNZB; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK7WDNZB"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b042ec947e4so190856166b.0;
        Thu, 04 Sep 2025 11:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757012157; x=1757616957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x+816UkHLyRvuKb/oS0wEATvXuUn8rJpVOodqIFEeMc=;
        b=dK7WDNZBerR+VPeVOCl3OIc33i2PTq8ifvQD0zu6i8wbdcy7tBnyN3SD3n+7P78qV6
         SGYnIznMz4Go+hxf0DE/rgWgqcdd+ccbL7zioJ/URwzmd/CnOiTKzCZNQ0/Pz96ApU24
         BL8wS8zR5Y6PPidnhi3MymOUWGca9JXhjeSsuqDgkei/2LZBHCcgPnkqhiHznCodLVH+
         obceruzvEgfa+j3sL+hTWZfHN0+UdF++P+R5zoqQLs/HOSlaJ/npv1F3nmDwTYl7Md7g
         /kIMrGgQ00c+IsCA5g0/f6F13DMcUuYz5ZLKsN0LEE+89PX/ZUL05onDpvr2Q/aSdFVx
         NXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757012157; x=1757616957;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+816UkHLyRvuKb/oS0wEATvXuUn8rJpVOodqIFEeMc=;
        b=CSriK9JOjW6yPMWfPicZLserLvSP3cUoRQHV5jLQO0CRvfsrSjZUzQdJQ7Krh5By+o
         iYaSvncd7ZV0fYLoakiw0h9Xoo7Qlv39Mp7aG4vDFjDGB5jNnDlXKvca8IMTUtdQmn55
         CXpop7a+qr6YuwFfhCA5C6H+odO7Ny24546TmgHB7R5sntQbpEMWI4ygYgy2Rh47uz75
         4YwrOGk6jFC+XiG4FWioZZX50vSgrNfygycbpiO8TDYtC55+J8ToVwmYq7o8tGB1ckcy
         dWEHFXWTF6iTDB+FQYjJnAG/94ByQk4k+CYvzK5tLBQNcit2NpTEZc28Q67SRK0ER6IW
         F6LQ==
X-Forwarded-Encrypted: i=1; AJvYcCV385xp3fdDUY0duW2VnCyJ8/AdPHImHTnvn3TKda+HZUkkbhHexfjUwn6Hudxx+U0F/tkSDjkd2ModVjKLQS7ryv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwPetL5BrV9TKv74R5x20sV0/Ohnm4hm3QayKzB0oJHQB76oyS
	ok5DmCZgiFdc+Ebz4/RUM9a7/0o9XVSHJOwSVeO1b/gLjbRbIG0h36Fd8hx9948=
X-Gm-Gg: ASbGnctYDFiOeVSsMMIJd2GtevfT16aNZl0VCVrW8g6km0zD2c+qfOFvq8qIDWGP9WH
	Bk8RJwhmqFUnf6U2jvjU3K1fyTm+p5mhxN2gtIGVxiKhnjw9t+XP6YMhoIUrrIrART4JrsrIfDJ
	a62qsWAUKQCzLpJrZ6KxVBsvnGCXRCoXwSzD3AHUNud+zxx1pIqDEQGzWex8Bm6t/W2QnS/SZYe
	wLTs7Vhb1nIfNqnIrGNmqCY/DPmD9SekEMQNHdBmJkHuFGD1fEhe7E2e5ZSTdnbEmT64hMxcXo2
	FSzuT2nxy5SwMQx9VEZASEZ5qoB7xSgt8uZZJ/nqih36uMsE7woXgr5cYo/jZQzbN51vbBHiG0E
	TbV8ym0AidPYUjLTHpyc+g1UN
X-Google-Smtp-Source: AGHT+IH6hCkzixDEoXC066qWnrd9dEDM6/UFAPpWA4TgP+SASVOvp5vF42WuuOBc/0+HA8JSRaKHsQ==
X-Received: by 2002:a17:907:7ba0:b0:af1:f259:254d with SMTP id a640c23a62f3a-b01d8a2fd7emr1924490366b.8.1757012156863;
        Thu, 04 Sep 2025 11:55:56 -0700 (PDT)
Received: from vova-pc ([46.161.125.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff12a6b404sm1509147666b.88.2025.09.04.11.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 11:55:56 -0700 (PDT)
Date: Thu, 4 Sep 2025 20:55:54 +0200
From: Vladimir Riabchun <ferr.lambarginio@gmail.com>
To: ferr.lambarginio@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mark.rutland@arm.com, mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v2] ftrace/samples: Fix function size computation
Message-ID: <aLngumfBZLyxPgvO@vova-pc>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK3d7vxNcO52kEmg@vova-pc>

Friendly ping.

Best regards,
Riabchun Vladimir
