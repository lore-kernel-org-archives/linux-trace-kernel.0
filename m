Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9E718E77E
	for <linux-trace-kernel@vger.kernel.org>; Thu,  8 Aug 2024 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134008; cv=none; b=eb6XInaeYMDeAs70jtoXqFgqXlxfv6xo9nYmBFFNtU0TqNIgP/0Q70f2TXegof0ImpOPskcX538HKDgBpxJFRkZoBpzcW0+daFjtjg3qZi6hIZSiYbl4bjlw2pKioA9AtxQ2EzMRBPaFxoGxwE97orE+1E8jWmQyBTWJUO7VRuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134008; c=relaxed/simple;
	bh=P/pVQXy6F0uUkKwDizlXzNmUOGplIeHHGdy6r0tuh/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GB0+IdXSYy5M5ujfSExZCohsJootm3+oX2y1Q5DrpIK35efwRnOKlRZKngLemnu+fgsmoE6vPWtcRY86rhcWgb5iGYaBvRa33cWQmd0VWZ4C6p9yoKcCxYOLDQF0xvOKIq78BjUnO/VttokjK5G/I/EHZciibfMmJYIeLQ+2p4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kX51VQsN; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kX51VQsN"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52f01613acbso2425620e87.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 08 Aug 2024 09:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723134005; x=1723738805; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P/pVQXy6F0uUkKwDizlXzNmUOGplIeHHGdy6r0tuh/M=;
        b=kX51VQsNCfzuZMarh1CWs9yqqDKqewZdMq+3qTCnsv/VvIlTamFkvXyOm2KXsBGEmj
         P3ZY1xQQqk09Ywb7CQk2VqpVObKwSrjMjhEr6rCIeL0KF+2XBZWoR7xUcDC+QYn+NmmS
         RJpnfef/440k/NroQqHyDl7eVjXgliNBVzYtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723134005; x=1723738805;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/pVQXy6F0uUkKwDizlXzNmUOGplIeHHGdy6r0tuh/M=;
        b=pBrLdk+hbPPz33aBn5F/vTUQ4g+VQFyFgzS8NyYsEfcalNj/aw8f5fYCSQV+WycCJ5
         m0UldvnDzr5uznABIW8ixqh+ac3130ula1zFn7Em4Xnf96qqmxZ+H+OSTue28DLWoQjm
         xd2QLlTyq4x7HfrL9jqHW3se6OQnJ7Gi6UDL+aHms+GSqQ8vRQjhfM6rqo37uuGKgKen
         IvhIrk2VWaf6LSKhoa0V9gKGykUoFuMM21clPzliowcvlMPuTIbS4jE1b8Dz5VZg5Mrr
         W6ra3iBrkImSfTuQP5EfonScQrPBy+18LtTFjYarCYJzIfEYwuE3ZOJNTp395JnYrJzH
         4YcA==
X-Forwarded-Encrypted: i=1; AJvYcCXqy9blW2Um5Ydojl36vip6VlqBoQtn+zzcWSnuJk8zguYXrJNecg5gbwJXkKxy6dlyDhOI8+O9PjpKAOrm9Q6S9lofrmtklpktdDoxwtepNATf
X-Gm-Message-State: AOJu0YyLn2zuijVRrMa5qotIZoGMoDeD76a9Y7WegCqb97ACunmvwEdF
	UWq9Sli5eYHoWopW8E2alCOnAVug21IRY0XvbKmtKBf6HK1H2VJI1FiwBPwYz2nFV0EndEeQ+SM
	lf5ldyypktFrNYXh7HipbQ/cwajzt3w+5rz8=
X-Google-Smtp-Source: AGHT+IGM+IplmOKg4nDNcKFtgq1VYsAyFc8E27t7Kh5kyZC1RNU1wOd40qJBqKGPW2Fz1pon2C+QpyksgQD83msyZMY=
X-Received: by 2002:a05:6512:1104:b0:52c:72b4:1b24 with SMTP id
 2adb3069b0e04-530e5d52447mr727655e87.12.1723134004820; Thu, 08 Aug 2024
 09:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620161903.3176859-1-takayas@chromium.org> <20240807211731.16758171@gandalf.local.home>
In-Reply-To: <20240807211731.16758171@gandalf.local.home>
From: Takaya Saeki <takayas@chromium.org>
Date: Fri, 9 Aug 2024 01:19:52 +0900
Message-ID: <CAH9xa6cRGK_oscsDNuAm-ZCJmfkfbm1yOTg_6SSzrkojY-CKFQ@mail.gmail.com>
Subject: Re: [PATCH v2] filemap: add trace events for get_pages, map_pages,
 and fault
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Junichi Uekawa <uekawa@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Oh yes. That sounds like a good idea. Let me update the patch with it.

Thanks,
Takaya Saeki
