Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D3320B22
	for <linux-trace-kernel@vger.kernel.org>; Sun, 10 May 2026 00:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778372857; cv=none; b=bCDrUQFWZy9PMX/tx6y+FdwJW0jhXmsuQLl07HHxs9KgqzRWThh+BKKAYmgM2PC1vINMjKfVmrnNKWG7+Z864C1gCka8GBMBc5nLkFWg48j1gSe8CmJOPbWIAFyOB6SOCWaqNf9fuo27lDPrYNWJwl3NhI4GPOlPds09DBzVMss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778372857; c=relaxed/simple;
	bh=yAGi5BRH4UPNo9k9/dyf7Jf/BhKO3oD99rTa54NlrMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbmRI5Jpz/xxXw/0DogisbyCANxUutBl4/6A0QUtIfemqkb9lcijrARDac/pYn4/5zJmqHGSFnf7e8Rn36nwKx3IOUfgZOUUNVjnOTdyaBEHIaLKV09YQZBXOdL3Q8W1SE20wlkpGf8FdXbU2NCcbSoTTWWOr6q21ZyRE7Pw7ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWIoQyWR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWIoQyWR"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bc763e2ba8so3768805ad.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 09 May 2026 17:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778372856; x=1778977656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ro1dSbK7YaXyzS6gYFkxsTldjrKUH9gqfqM+chPZiwo=;
        b=FWIoQyWRQJdOBPDngHKFQSE/qt+DXPuYZHjtpUTR5JLRbNRm32EC4YJuCrfYxBr/Dm
         mTK77pcP+Z9a603lR10xkaCw1WfWEvmrjuINbZHZMkBSuFPzbLB6GEyaNDBTqpn8kleT
         msGlbpXn0DYcWIJM+ccUDPK8RLUM3TY6ZxLjUgy7IOKLdNt2WD87+PGMA3P8hqjDdqHl
         YTTwYbubguB4nRskaHKKKTk8KNBFDncujxit5YVYzt+76ATSziW/RP0SypA1MWxkBxL9
         nHsSq1DxvpJ5tzAPOB6N8oIg47ErJwAkzIJlqIZCLfmjhKoIMROYAf0h1C1yI/Bpb/Dd
         gRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778372856; x=1778977656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ro1dSbK7YaXyzS6gYFkxsTldjrKUH9gqfqM+chPZiwo=;
        b=sOSkkqmncX4RpUiv6GTrDhMDD8bDxudQAX9nmaxJYGxYyD7x6MCXNI916Q21UKLe+8
         DWJprE/567KHxTX3DGF4yhK1zJ0JHolx0/f9yaLEbs/2Ev6ftUmvTzjSIJHTg1KvNhaR
         tWGYCzrLskvRPhr6QyDx8Iyv8BlwDNG2w3SaUaKxA2oxZfmW58ojSVCuQuGVsjL84/gs
         c5ul1y7f5AmcJGBCtjfkCoLLoUvSJ94ADIYpfi9OyfxmhQnqU7alAnEYA413NxX7Q2pO
         uVvc6f65w6hQ6oo4UssgvI9fLlgxbges++sDEJCOe6jn8DdtzUd2B7nsLd5lVM92VimL
         GYUw==
X-Forwarded-Encrypted: i=1; AFNElJ+PeK3H5vUwPaQm9YNT40WrbBMxlLO2wl4vgJvPGpEobhaa4F9bh3HMy9DTRwYZz+V5JsVjgVZW9N0y04UFeQj1nPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOQTNQvYPM+4FTtTnvdCDJ4E5XH4SHVjwbg4QbP/Sh+WvhF4PI
	p9NPy2UCc33q87rWxCqNuZStudsZ3bV0KyT0TN/mpcK0cudQdGChHRvC
X-Gm-Gg: Acq92OHvk9EQ4G9rwsRws2e7cS5VAk6X/vkUGfhx7XuFBOyNwWfhHmIJVUFSc1iPise
	ETWzLW8ORVlI2J87+8v1C2YOD/jPN9ly16qMnEWMvd0VL5OSDe5id9FmqEXCnessCK302vefmYE
	yNHxzhCMF7CkExqMs3JoS8oQPRgVCfe1Hl71NddIoNiGPvwrNjcEr2ftmDFj10Bv2VltpVp1nmp
	6ISz5DtO29fsw0ASJSTbkY93d2MhQ+pSXw8RH1JHS+FsuSdX/N9HJSfJQ4eMriYcEl2cyK8+X/9
	kAmGUVTFDjYZ0pJcki1jCGLGuAtoXpqFBkrr9+7gXRux4Q8a12UyM33zuM9mOP65ixvzZBQfF8N
	oausIOqqFC10ljdinwJZYYkNCOE2l2ziR4X/EMQl27qOPZPGuC4JRvs2uOVS9ZZ4/qAvTZOVFOs
	/old7daJIxfLhJlP11BKhJ7YmYPpGvwXpE110dL+bqlcpYpsAAo+ThCnE4zw==
X-Received: by 2002:a17:903:1b50:b0:2b2:5314:e96a with SMTP id d9443c01a7336-2ba7a32a517mr181332465ad.34.1778372855675;
        Sat, 09 May 2026 17:27:35 -0700 (PDT)
Received: from localhost ([154.39.63.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d40a65sm60925375ad.20.2026.05.09.17.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 17:27:35 -0700 (PDT)
Date: Sun, 10 May 2026 08:27:31 +0800
From: chenqiwu <qiwuchen55@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, hannes@cmpxchg.org,
	david@kernel.org, mhocko@kernel.org, willy@infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	"qiwu.chen" <qiwu.chen@transsion.com>
Subject: Re: [PATCH v2] mm: vmscan: rework lru_shrink and write_folio
 tracepoints
Message-ID: <20260510002731.GA5833@rlk>
References: <20260506083652.100160-1-qiwu.chen@transsion.com>
 <20260508164743.ef0194a1223d457bd0e13494@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508164743.ef0194a1223d457bd0e13494@linux-foundation.org>

On Fri, May 08, 2026 at 04:47:43PM -0700, Andrew Morton wrote:
> On Wed,  6 May 2026 16:36:52 +0800 "qiwu.chen" <qiwuchen55@gmail.com> wrote:
> 
> > From: "qiwu.chen" <qiwuchen55@gmail.com>
> > Signed-off-by: qiwu.chen <qiwu.chen@transsion.com>
> 
> Which should we use?  If it's the transsion.com address (which I
> assumed) then this can be communicated by placing an explicit From:
> line at start-of-changelog.
>
gmail address is used for communication, transsion.com is used for SOB
which cannot communicated with msmtp normally.
