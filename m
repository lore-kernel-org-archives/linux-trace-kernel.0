Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CCC18AF7;
	Thu, 21 Sep 2023 17:10:41 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556B0728F;
	Thu, 21 Sep 2023 10:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=gpXWMEFRdkUqRYHtPtMKumIpIyQIjDxThum2oS+gMZU=; t=1695316206; x=1696525806; 
	b=BogcftVBbpBYJX+dnGuaduFUghCyA5YB+3Mrlv3IKYWAdffEWEzOCxJ9gPLUfLt/aNQx68aLYhh
	wewb23qMM6Tk7rwRC2Ye0el61CtLtvR1RHMPHLkrVnhW/dLQqXLmKWKb2jhd8JB34jsRzisvXxKIG
	IjfYFCb46uMtLICWCyl+f76e6kMuXK2SvZzele+mEszMIxT67IDrXLR+cgiD5itoPut+E2iaO1WxG
	wenDf+opidxl2T9p1ONcsuTQNaiE6bI7eVKDOzRCuQehYVMQf7Vlt0JVcYtp7M1XLJ2F6PVhxJsxL
	Xg3WrX7DZggr6eRh/jbyvkQkrFFqnVi9VqVA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qjFPk-00D3lb-1B;
	Thu, 21 Sep 2023 10:52:00 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH 0/4] tracing: improve symbolic printing
Date: Thu, 21 Sep 2023 10:51:30 +0200
Message-ID: <20230921085129.261556-5-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

So I was frustrated with not seeing the names of SKB dropreasons
for all but the core reasons, and then while looking into this
all, realized, that the current __print_symbolic() is pretty bad
anyway.

So I came up with a new approach, using a separate declaration
of the symbols, and __print_sym() in there, but to userspace it
all doesn't matter, it shows it the same way, just dyamically
instead of munging with the strings all the time.

This is a huge .data savings as far as I can tell, with a modest
amount (~4k) of .text addition, while making it all dynamic and
in the SKB dropreason case even reusing the existing list that
dropmonitor uses today. Surely patch 3 isn't needed here, but it
felt right.

Anyway, I think it's a pretty reasonable approach overall, and
it does works.

I've listed a number of open questions in the first patch since
that's where the real changes for this are.

johannes


