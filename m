Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B94154449
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jul 2024 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916051; cv=none; b=YBzlMEYN9654jCnRAL0Vz18toNREkC/yUSL4RG71PQcFqOGWedRguk+wcIbFCkFerV12dMpSye+FTBQTFr8k2E9xX9MOVF+BOGaEE/5AVnZxinV3MMP0BEFXVUHIBhrzBNEhNA0bJytb17ewIuuCCu1Dj7sgsDtThNAKS1ZQ41c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916051; c=relaxed/simple;
	bh=KGXL9UIXbhLR/5JvNqArR0R/XDUz/ACK4RQxzl9anNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t95DESaE54iZchXE93nTkdkLvHr7AQqbfEoBGXYbIcw7MNnNXkush0oMBwM3DtNraDq0JLM4fS8MaMraNLv/8QQ+8xBb0XSoayeudF6d/EpWl4Ayz/esrw+Sn9LlsCRDhPKBUut3VXemsTbgXVdtpCRyJAjtscz2LE4F63l5a5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dcF3u2tl; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dcF3u2tl"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ec6635aa43so40095191fa.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jul 2024 03:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719916048; x=1720520848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KGXL9UIXbhLR/5JvNqArR0R/XDUz/ACK4RQxzl9anNE=;
        b=dcF3u2tlMqqlru7dKg9knlyIzk51sfjgrzlPJFKgID15PJVypodb7PvoEtCxIcWjGJ
         wcl7cEbePp7tbVOY5/TVrVd29I2d7Z+ySRuRcaiDJlNvsSZb6BAs49S/QMAqSsfgW0ro
         x4/eKqGPlRxWj+pnId9kqbXYhrp6kCiu0C1F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719916048; x=1720520848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGXL9UIXbhLR/5JvNqArR0R/XDUz/ACK4RQxzl9anNE=;
        b=YncUvuLLkqnWQWNxtj5FLOvz+pvwT+lxKqwWTJkht06s7Z6C749pCzTHChdQ0Xatk4
         noNu4/phdZ0q7UXd6USLvS/b0joAXaIagG/mlI5pBmNVAyys+FMCM0qUhbFLHMbDgiVm
         4HShJGMgETaO5nzuTFMWUplbKxfJH0jT3QBqDabPNjHFpvJekfz6jEXz5sZYdgIcO4cJ
         fMjJPPbD08tpAJn8Hg2RYUQ+Bh41VVXKXw1Cznqar+fOJlosLy9i7RqphVHFJ+KszDIg
         T+BgQH2AftfKMQQBKaRxid2Bufqow9lqw3cN3GZyCP9w7p3ndmGAfG9pPB6KamQ5qL34
         5cNg==
X-Forwarded-Encrypted: i=1; AJvYcCV4kBon1d70oHX3s8eVgvX3DjfHs3zpMZjvSA3hzIVrtSNUj09hN5CPYJbcifqIqaSIwskfSUKFj5FaINuXOkKB0jhGGPC5GwhD5zV4DKbLy57y
X-Gm-Message-State: AOJu0YzlSzM1rclVlmJKYIiJC+fXfRrEWN58O8TABQYInC7TYdTUT7ZV
	fk0TzoOebLvKq/gj6SJIiOznjmjBpC266HTRtvFEqsGqcfYNZZg5JmXNzaBXN1uwTcPnzCkn3Fn
	qqw0Zf0Rei2lhoOwxHyAiZyec0DhmheH2HTU=
X-Google-Smtp-Source: AGHT+IFt9f8DTWYXKkF3t2wQ2KUJR9FCI77sv6cMg7QIh3R6KT4/CDFbLN8uqeQubI+1wZca4MimuTa7HkZzfMW2UOo=
X-Received: by 2002:a2e:9ece:0:b0:2ee:594b:8b80 with SMTP id
 38308e7fff4ca-2ee5e6f7a8fmr43928381fa.52.1719916048118; Tue, 02 Jul 2024
 03:27:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620161903.3176859-1-takayas@chromium.org>
 <20240626213157.e2d1b916bcb28d97620043d1@kernel.org> <20240626095812.2c5ffb72@rorschach.local.home>
In-Reply-To: <20240626095812.2c5ffb72@rorschach.local.home>
From: Takaya Saeki <takayas@chromium.org>
Date: Tue, 2 Jul 2024 19:27:16 +0900
Message-ID: <CAH9xa6ej2g+DvCd=cqjj8sx9yZ=DjL6Ffu6aOfebvcjBmGs5pQ@mail.gmail.com>
Subject: Re: [PATCH v2] filemap: add trace events for get_pages, map_pages,
 and fault
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Junichi Uekawa <uekawa@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Hello all, and thank you so much for the review, Steven and Masami.

I'm currently considering replacing the `max_ofs` output with
`length`. Please let me know your thoughts.
With the current design, a memory range of an event is an inclusive
range of [ofs, max_ofs + 4096]. I found the `+4096` part confusing
during the ureadahead's upstreaming work. Replacing `max_ofs` with
`length` makes the range specified by an event much more concise.
