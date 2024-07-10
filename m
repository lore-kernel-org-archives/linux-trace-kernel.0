Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBDB127E18
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599658; cv=none; b=OUvf13QkLuYPmjzQxv95kDy1EAwTeXLGJidvllza6QMVr2E7sBuUsOz0O9wCvMoycgEiA96g+Id9AEIuHv+cd8+uB1nDt3IBqq2/N8VQGa+2ztRELh/OaUDs8t3ea56mEiD1ADq2EpPfsKLw7Yl5y5CBquCkWCCKd+BcxtT4qfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599658; c=relaxed/simple;
	bh=E+RlSDDTSsw+TczheJFJM0ymz3DgCZJKh5AaCvk1b9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3AFJnsxx1CPUhA+9fnh/QG/fYH19ArgIpwo0ikN5kF+4Ss0PX6jsH7/xkYosL4tfGciZobgyK1VDoSKnmOUiWakLdKlqz61Z+tyUZkKu5kwm3Gh7TzAbcE7RLratPi9hSQpohVY9kEyS4sW5syDt2S70j8wrrY+rqXPswYipwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZLIBhcfm; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZLIBhcfm"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eea8ea8bb0so50347981fa.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720599655; x=1721204455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E+RlSDDTSsw+TczheJFJM0ymz3DgCZJKh5AaCvk1b9Q=;
        b=ZLIBhcfmXNzxci9p7l2DkVuG2NlGxfs2vR3FypWbXi1IxHvgyhsnYPbW4JrojtAk3p
         +r5zzmwqUoTm8tLsIlLsk3DnIaXBSotsziUha+GWSj0L1XVGjQCbkXUe9MYjQREiDtwb
         cHQ2r+ZELLQXV0iS/DjYnaSBVtuTDpnfJmRvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720599655; x=1721204455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+RlSDDTSsw+TczheJFJM0ymz3DgCZJKh5AaCvk1b9Q=;
        b=FHPB70E1ZJ1OmQlXgZ68m7zqWzsafuaUny+6RI647QoSCD4llHXJM++NCR/fkmwntX
         lTgRwV4LYOUWJI9g9Gx6ukb6atU5drYQdcCcStbZuQWQso7KB7Bs70Mu1xLjImCaCVf3
         67FCO1b63DDIzZIsf22x+c9Lhi+XXkYWpO+a4zMMK/hJhkpGQubqmmvPoQIS21fpWm3z
         ToOL0FKpyvkp4QRnQbfyCK3SLupATcbcMDH5Td5goKUgq2tsnnWMJe1ocB1cpotOih4K
         Nj2+j00dhVEpLuIBA9IUx+BUMn9sJkl8CUXy0hs85GbOZCvVPJBgqzMa0+gUnHgcuYiY
         5XLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6TA5j/dc+O8HC/juZdvgbWUJOXFydl7w1yPZm7UCnYiyolnkoanKdCLOWW8MPfeiuVbL+aCzJIJA/et2wrNOXzq60RNyZ2X+jsXO8KR8IKi1b
X-Gm-Message-State: AOJu0YzWajbp2mqf1BDKOSQY1xuHT5qNxzZxslyJe1Gu/xbXWG2MMCJ1
	vnKXcg5R65dsedVvCxOr6aXOLaik7UQLCJLg3cwjwyMhCcRQsiMBAo/CdHFozIDM4e4FlCHQ+H+
	9Sa+I6nem+y8uS7l2q26BND9AZOSjLtUNPPs=
X-Google-Smtp-Source: AGHT+IEAq4kkSUgtsxyOH15D6jkCwSRAL31AifedA+YyD0JGizHJjSS3vklJsbyYJkyWrD4JVRnuf2baYIixrqDEEAk=
X-Received: by 2002:a2e:9b50:0:b0:2ee:be50:52d5 with SMTP id
 38308e7fff4ca-2eebe5055d9mr14147121fa.43.1720599655293; Wed, 10 Jul 2024
 01:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620161903.3176859-1-takayas@chromium.org>
 <20240626213157.e2d1b916bcb28d97620043d1@kernel.org> <20240626095812.2c5ffb72@rorschach.local.home>
 <CAH9xa6ej2g+DvCd=cqjj8sx9yZ=DjL6Ffu6aOfebvcjBmGs5pQ@mail.gmail.com> <20240702123747.796b98c5@rorschach.local.home>
In-Reply-To: <20240702123747.796b98c5@rorschach.local.home>
From: Takaya Saeki <takayas@chromium.org>
Date: Wed, 10 Jul 2024 17:20:42 +0900
Message-ID: <CAH9xa6eGynkLNaSixQXOZMDTgi4H8vb6eY8e92aGRnbPPq_pPQ@mail.gmail.com>
Subject: Re: [PATCH v2] filemap: add trace events for get_pages, map_pages,
 and fault
To: Matthew Wilcox <willy@infradead.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Junichi Uekawa <uekawa@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

Hello Matthew, I'd appreciate it if you could comment on this.

Thank you.
