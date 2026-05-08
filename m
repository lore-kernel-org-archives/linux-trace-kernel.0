Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A48F3128CA
	for <linux-trace-kernel@vger.kernel.org>; Fri,  8 May 2026 23:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778284065; cv=none; b=hJEurI2yfF2c+NZluS/sDo+5FApH62P6aERiBuoTTMZB0Bjpm1c14wk7LjcnO/eQNdUEoryoRjfWVoYBu6efAJwhuy45rUj889OnLiRsi/8fhle62fsA4TB+qZrSTB5QvX5KbxfqnnrKb/MLRvAY2ilAbNUPxQ+TKJTCd2rpe2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778284065; c=relaxed/simple;
	bh=In6mExfDK0WyJofjqOpw12k5j7oFkvfjNkoq9uSjvIk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YnQ1WocOrv46SjMFxQBFVB9WVXXdunqrozgxHoifdrUGxO+eir67vCkuR3nic0aZdaUajYkStXHz/3kK3G6gdJ5G8lO9E7ZWz0amQtqZv4cBebryTdN13RxPB0bjamX0xYegEYCb3phssOhWL/co29r/rBJ7gnFbN0+JZnMauK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Hq1NlkSy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Hq1NlkSy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B868C2BCB0;
	Fri,  8 May 2026 23:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1778284064;
	bh=In6mExfDK0WyJofjqOpw12k5j7oFkvfjNkoq9uSjvIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hq1NlkSy/tqoEaG9NZ00YF/G5p5WPnkiW0wabW7QTa5+SfoSP8Dp683i4N50fbS/d
	 NgwDhbl8GConviwL8HbJhnR69NgHaI0VmCj99nvFosYx4knOF8BXBxCSt3wkdMog6s
	 +HsoJ6WRXK4xyJCsGpcQ5DwxQtbtSmojYTPTeqa8=
Date: Fri, 8 May 2026 16:47:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "qiwu.chen" <qiwuchen55@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, hannes@cmpxchg.org,
 david@kernel.org, mhocko@kernel.org, willy@infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, "qiwu.chen"
 <qiwu.chen@transsion.com>
Subject: Re: [PATCH v2] mm: vmscan: rework lru_shrink and write_folio
 tracepoints
Message-Id: <20260508164743.ef0194a1223d457bd0e13494@linux-foundation.org>
In-Reply-To: <20260506083652.100160-1-qiwu.chen@transsion.com>
References: <20260506083652.100160-1-qiwu.chen@transsion.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 May 2026 16:36:52 +0800 "qiwu.chen" <qiwuchen55@gmail.com> wrote:

> From: "qiwu.chen" <qiwuchen55@gmail.com>
> Signed-off-by: qiwu.chen <qiwu.chen@transsion.com>

Which should we use?  If it's the transsion.com address (which I
assumed) then this can be communicated by placing an explicit From:
line at start-of-changelog.

